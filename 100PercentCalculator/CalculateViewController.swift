//
//  CalculateViewController.swift
//  Percentages
//
//  Created by Thomas Andre Johansen on 21/01/16.
//  Copyright © 2016 Appkokeriet. All rights reserved.
//

import UIKit
import GoogleMobileAds
import iAd

class CalculateViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate   {

    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var labelTextOne: UILabel!
    @IBOutlet weak var labelTextTwo: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calculatedValue: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    
    var passedCell:MenuCell!
    var calculate:Calculate!
    let defaults = UserDefaults.standard
    
    let formatter = NumberFormatter()
    
    let bottomBorder = CALayer()
    let bottomBorder2 = CALayer()
    let urlButton = UIButton(type: .custom)


    var adMobBannerView = GADBannerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTitle.text! = passedCell.labelTitle
        topTitle.sizeToFit()
        labelTextOne.text! = passedCell.labelNumberOne
        labelTextTwo.text! = passedCell.labelNumberTwo
        resultLabel.text! = passedCell.labelResult
        resultLabel.sizeToFit()
        
        subtitleLabel.minimumScaleFactor = 0.5
        
        textFieldOne.keyboardType = .decimalPad
        textFieldTwo.keyboardType = .decimalPad
        
        
        textFieldOne.delegate = self
        textFieldTwo.delegate = self
        
       
        
        
        bottomBorder.frame = CGRect(x: 0.0, y: textFieldOne.frame.size.height - 1, width: textFieldOne.frame.size.width, height: 1.0);
        bottomBorder.backgroundColor = UIColor.black.cgColor
        textFieldOne.layer.addSublayer(bottomBorder)
        bottomBorder2.frame = CGRect(x: 0.0, y: textFieldTwo.frame.size.height - 1, width: textFieldTwo.frame.size.width, height: 1.0);
        bottomBorder2.backgroundColor = UIColor.black.cgColor
        textFieldTwo.layer.addSublayer(bottomBorder2)
                
        //add gesture recognizer to hide keyboard on tap
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalculateViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        if(passedCell.calculateFunction == "about"){
            let image = UIImage(named: "aboutLogo-Small") as UIImage?
            urlButton.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width,height: (image?.size.height)!)
            urlButton.addTarget(self, action: #selector(CalculateViewController.openUrl(_:)), for: .touchUpInside)
            urlButton.isEnabled = true
            urlButton.setImage(image, for: UIControlState())
            view.addSubview(urlButton)

        }
        
        
        //add view for default values
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit , target: self, action: #selector(CalculateViewController.openEdit(_:)))
        self.navigationItem.rightBarButtonItem = editButton
        
        
        //MARK: -AD
        // add ad
        // Set delegate and hide banner initially
        
        adMobBannerView.adUnitID = "ca-app-pub-8190128329666781/6452073158"
        adMobBannerView.delegate = self
        adMobBannerView.rootViewController = self
        adMobBannerView.frame.size.height = kGADAdSizeBanner.size.height
        adMobBannerView.frame.size.width = UIScreen.main.bounds.width //kGADAdSizeBanner.size.width
        
        let request = GADRequest()
        //request.testDevices = ["b0e0523adf777aea3cbaf0728bb2e747"]
        adMobBannerView.isHidden = false
        adMobBannerView.load(request)
        
        //MARK: inputAccessoryView
        let keyboardButtons =  UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width, height: 50))
        let previousButton = UIButton(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width/10,height: 50))
        let nextButton = UIButton(frame: CGRect(x: previousButton.frame.origin.x+previousButton.frame.width,y: 0,width: UIScreen.main.bounds.width/10,height: 50))
        let doneButton = UIButton(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width/4,height: 50))
        previousButton.setTitle("◀︎", for: UIControlState())
        previousButton.addTarget(self, action: #selector(CalculateViewController.toggleFirstResponder(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(CalculateViewController.toggleFirstResponder(_:)), for: .touchUpInside)
        nextButton.setTitle("▶︎", for: UIControlState())
        doneButton.setTitle("✓", for: UIControlState())
        doneButton.frame.origin.x = UIScreen.main.bounds.width-doneButton.frame.width
        doneButton.addTarget(self, action: #selector(CalculateViewController.dismissKeyboard), for: .touchUpInside)
        
        keyboardButtons.addSubview(previousButton)
        keyboardButtons.addSubview(nextButton)
        keyboardButtons.addSubview(doneButton)
        keyboardButtons.backgroundColor = UIColor.blue
        textFieldOne.inputAccessoryView = keyboardButtons
        textFieldTwo.inputAccessoryView = keyboardButtons
    }
    
    override func viewWillAppear(_ animated: Bool) {
        percentLabel.isHidden = true
        calculatedValue.isHidden = true
        resultLabel.isHidden = true
        subtitleLabel.isHidden = true
        //if numbertwo is in percentages
        if(passedCell.percent){
            percentLabel.isHidden = false
        }

        if(passedCell.calculateFunction == "about"){
            print("in about calculateviewcontroller")
            textFieldOne.isHidden = true
            textFieldTwo.isHidden = true
            
            topTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            labelTextOne.font = UIFont(name: "HelveticaNeue-UltraLight", size: 14)
            labelTextOne.numberOfLines = 2
            labelTextOne.center = CGPoint(x: view.frame.midX, y: topTitle.center.y+topTitle.frame.size.height)
            labelTextOne.textAlignment = .center
            
            labelTextTwo.font = UIFont(name: "HelveticaNeue", size: 16)
            labelTextTwo.numberOfLines = 2
            
            resultLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 14)
            resultLabel.center.y = labelTextTwo.center.y+resultLabel.frame.size.height
            resultLabel.numberOfLines = 2
            resultLabel.isHidden = false
            
            calculatedValue.text = ""
            calculatedValue.isHidden = true
            
            subtitleLabel.center.y = resultLabel.center.y+subtitleLabel.frame.size.height
            subtitleLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 14)
            subtitleLabel.text = NSLocalizedString("FEEDBACK_REPORT_TEXT", comment: "")+" support@appkokeriet.no"
            subtitleLabel.isHidden = false
            
            //hide edit button
            self.navigationItem.rightBarButtonItem = nil
            
            
            //link til itunes
            //
            
        }else{
            
      
        }
        //try to add default values to textFields
        if (defaults.string(forKey: labelTextOne.text!) != nil){
            textFieldOne.text = defaults.string(forKey: labelTextOne.text!)!
            self.calculateValue(textFieldOne)
        }else{
            textFieldOne.text = nil
        }
        if (defaults.string(forKey: labelTextTwo.text!) != nil){
            textFieldTwo.text = defaults.string(forKey: labelTextTwo.text!)!
            self.calculateValue(textFieldTwo)
        }else{
            textFieldTwo.text = nil
        }
    }
    override func viewDidLayoutSubviews(){
        //redraw textfield bottomborders if something changes
        bottomBorder.frame = CGRect(x: 0.0, y: textFieldOne.frame.size.height - 1, width: textFieldOne.frame.size.width, height: 1.0);
        bottomBorder2.frame = CGRect(x: 0.0, y: textFieldTwo.frame.size.height - 1, width: textFieldTwo.frame.size.width, height: 1.0);
        //where to put ads
        adMobBannerView.center = CGPoint(x: view.frame.midX,
            y: view.frame.height - adMobBannerView.frame.height / 2)
        
        switch (passedCell.calculateFunction){
            case "about":
                labelTextOne.center = CGPoint(x: view.frame.midX, y: topTitle.center.y+topTitle.frame.size.height)
                //remove the image if the device is pre iPhone4s
                if (view.frame.height <= 480){
                    urlButton.setImage(nil, for: UIControlState())
                    urlButton.setTitle("www.appkokeriet.no", for: UIControlState())
                    urlButton.titleLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 12)
                    urlButton.setTitleColor(UIColor.black, for: UIControlState())
                }
                urlButton.center = CGPoint(x: view.frame.midX, y: view.frame.height-70-urlButton.frame.height/2)
            case "findPercentValue":
                percentLabel.isHidden = false
                percentLabel.center.y = labelTextOne.center.y
            case "contributionMarginRatio":
                percentLabel.isHidden = false
                percentLabel.center.y = labelTextOne.center.y
            default:
            break
            }
        


    }
    
    
    func openUrl(_ sender: UIButton){
        if let url = URL(string: "http://www.appkokeriet.no") {
            if #available(iOS 10.0, *){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func toggleFirstResponder(_ sender:UIButton){
        if (textFieldOne.isFirstResponder){
            textFieldTwo.becomeFirstResponder()
        }else{
            textFieldOne.becomeFirstResponder()
        }
    }
    
    //calculate the value as user types
    @IBAction func calculateValue(_ sender: UITextField) {
        let calculate = Calculate(funcToCall: passedCell.calculateFunction)
        if (!textFieldOne.text!.isEmpty && !textFieldTwo.text!.isEmpty){
            let formattedNumberOne = formatter.number(from: textFieldOne.text!)
            let formattedNumberTwo = formatter.number(from: textFieldTwo.text!)
            let result = calculate.selectFunction(Double(formattedNumberOne!.doubleValue), numberTwo: Double(formattedNumberTwo!))
            resultLabel.sizeToFit()
            resultLabel.isHidden = false
            calculatedValue.text = result.0
            calculatedValue.sizeToFit()
            calculatedValue.isHidden = false
            subtitleLabel.text = result.1
            subtitleLabel.sizeToFit()
            subtitleLabel.isHidden = false
        }else{
            calculatedValue.isHidden = true
            resultLabel.isHidden = true
            subtitleLabel.isHidden = true
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let formattedText = formatter.number(from: text)
        if (formattedText != nil || text.isEmpty){
            return true
        }else{
            return false
        }

    }
    
    // MARK : banner
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        //print("Did receive ad! Adder subview: \(bannerView.adNetworkClassName)")
        view.addSubview(adMobBannerView)

    }

    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
         print("didFailToReceiveAdWithError \(error) + \(bannerView.adNetworkClassName)")
        adMobBannerView.isHidden = true
    }
    func openEdit(_ sender: AnyObject?){
        self.performSegue(withIdentifier: "editViewSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        view.endEditing(true)
        let newView = segue.destination as! EditViewController
        newView.passedCell = self.passedCell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
