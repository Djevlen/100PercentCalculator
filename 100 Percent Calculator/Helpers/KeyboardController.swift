//
//  KeyboardController.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 02/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import Foundation
import UIKit


final class KeyboardController: ObservableObject {
    @Published var height: CGFloat = 0
    @Published var isPresent: Bool = false
    
    private var notificationCenter: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        print("inititting keyboard")
    }
    
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            isPresent = true
            height = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        isPresent = false
        height = 0
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
}
