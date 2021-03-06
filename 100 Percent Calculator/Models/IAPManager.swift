//
//  IAPManager.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 27/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import StoreKit

class IAPManager: NSObject {
    
    enum IAPManagerError: Error {
        case noProductIDsFound
        case noProductsFound
        case paymentWasCancelled
        case productRequestFailed
    }
    
    static let shared = IAPManager()
    var onReceiveProductsHandler: ((Result<[SKProduct], IAPManagerError>) -> Void)?
    var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
    var restoredProducts: Int = 0
    var products : [SKProduct]?
    var proProduct : SKProduct?

    private override init(){
        super.init()
    }
    
    func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<[SKProduct], IAPManagerError>) -> Void) {
        // Keep the handler (closure) that will be called when requesting for
        // products on the App Store is finished.
        onReceiveProductsHandler = productsReceiveHandler
     
        // Get the product identifiers.
        guard let productIDs = getProductIDs() else {
            productsReceiveHandler(.failure(.noProductIDsFound))
            return
        }
     
        // Initialize a product request.
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
     
        // Set self as the its delegate.
        request.delegate = self
     
        // Make the request.
        request.start()
    }
    
    func getPriceFormatted(for product: SKProduct) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)
    }

    func buy(product: SKProduct, withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
     
        // Keep the completion handler.
        onBuyProductHandler = handler
    }
    
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
     
    func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    func restorePurchases(withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
        onBuyProductHandler = handler
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func loadProducts(userSettings: UserSettings){
        IAPManager.shared.getProducts { (result) in
            print("getting products")
            DispatchQueue.main.async {
                switch result{
                case .success(let products):
                    if userSettings.isProUser{
                        self.products = products.filter {!$0.productIdentifier.lowercased().contains("pro")}
                    }else {
                        self.products = products
                    }
                    self.proProduct = products.first(where: {$0.productIdentifier.lowercased().contains("pro")})
                    userSettings.hasLoadedProducts = true
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
}

extension IAPManager: SKProductsRequestDelegate {

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // Get the available products contained in the response.
        let products = response.products
     
        // Check if there are any products available.
        if products.count > 0 {
            // Call the following handler passing the received products.
            onReceiveProductsHandler?(.success(products))
        } else {
            // No products were found.
            onReceiveProductsHandler?(.failure(.noProductsFound))
        }
    }
    
    func requestDidFinish(_ request: SKRequest) {
        //do stuff when finsihed?
        print("requestDidFinish!: \(request)")
    }
}

extension IAPManager.IAPManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noProductIDsFound: return "No In-App Purchase product identifiers were found."
        case .noProductsFound: return "No In-App Purchases were found."
        case .productRequestFailed: return "Unable to fetch available In-App Purchase products at the moment."
        case .paymentWasCancelled: return "In-App Purchase process was cancelled."
        }
    }
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchased:
            onBuyProductHandler?(.success(true))
            SKPaymentQueue.default().finishTransaction(transaction)
             
            case .restored:
                restoredProducts += 1
                SKPaymentQueue.default().finishTransaction(transaction)
             
            case .failed:
            if let error = transaction.error as? SKError {
                if error.code != .paymentCancelled {
                    onBuyProductHandler?(.failure(error))
                } else {
                    onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
                }
            }
            SKPaymentQueue.default().finishTransaction(transaction)
             
            case .deferred, .purchasing: break
            @unknown default: break
            }
        }
    
       }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if restoredProducts != 0 {
            onBuyProductHandler?(.success(true))
        } else {
            print("IAP: No purchases to restore!")
            onBuyProductHandler?(.success(false))
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let error = error as? SKError {
            if error.code != .paymentCancelled {
                print("IAP Restore Error:", error.localizedDescription)
                onBuyProductHandler?(.failure(error))
            }
        }
    }
}

fileprivate func getProductIDs() -> [String]? {
    guard let url = Bundle.main.url(forResource: "iap_productIDs", withExtension: "plist") else { return nil }
    do {
        let data = try Data(contentsOf: url)
        let productIDs = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String] ?? []
        return productIDs
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

