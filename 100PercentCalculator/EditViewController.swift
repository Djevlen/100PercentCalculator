//
//  EditViewController.swift
//  Percentages
//
//  Created by Thomas Andre Johansen on 10/02/16.
//  Copyright © 2016 Appkokeriet. All rights reserved.
//
// TODO: THIS ENTIRE VIEW SHOULD BE INTEGRATED INTO THE CalculateViewController

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    var passedCell:MenuCell!
    let defaults = UserDefaults.standard
    

    @IBOutlet weak var labelTextOne: UILabel!
    @IBOutlet weak var labelTextTwo: UILabel!
    
    @IBOutlet weak var textFieldTwo: UITextField!
    @IBOutlet weak var textFieldOne: UITextField!
    
    @IBOutlet weak var defaultValueLabel: UILabel!
    @IBOutlet weak var saveValuesButton: UIButton!
    @IBOutlet weak var restoreDefaultButton: UIButton!
    let bottomBorder = CALayer()
    let bottomBorder2 = CALayer()
    
    @IBOutlet weak var saveResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTextOne.text! = passedCell.labelNumberOne
        labelTextTwo.text! = passedCell.labelNumberTwo
        saveResultLabel.isHidden = true
        textFieldOne.delegate = self
        textFieldTwo.delegate = self
        textFieldOne.keyboardType = .decimalPad
        textFieldTwo.keyboardType = .decimalPad
        bottomBorder.frame = CGRect(x: 0.0, y: textFieldOne.frame.size.height - 1, width: textFieldOne.frame.size.width, height: 1.0);
        bottomBorder.backgroundColor = UIColor.black.cgColor
        textFieldOne.layer.addSublayer(bottomBorder)
        bottomBorder2.frame = CGRect(x: 0.0, y: textFieldTwo.frame.size.height - 1, width: textFieldTwo.frame.size.width, height: 1.0);
        bottomBorder2.backgroundColor = UIColor.black.cgColor
        textFieldTwo.layer.addSublayer(bottomBorder2)
        
        defaultValueLabel.text = String(format: NSLocalizedString("DEFAULT_VALUE_LABEL", comment: "The default value label"))
        restoreDefaultButton.setTitle(NSLocalizedString("RESTORE_DEFAULT_BUTTON",comment:"restore defaults button"), for: UIControlState())
        saveValuesButton.setTitle(NSLocalizedString("SAVE_VALUES_BUTTON",comment:"save values button"),  for: UIControlState())
        //add gesture recognizer to hide keyboard on tap
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
        //MARK: inputAccessoryView
        let keyboardButtons =  UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width, height: 50))
        let previousButton = UIButton(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width/10,height: 50))
        let nextButton = UIButton(frame: CGRect(x: previousButton.frame.origin.x+previousButton.frame.width,y: 0,width: UIScreen.main.bounds.width/10,height: 50))
        let doneButton = UIButton(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.width/4,height: 50))
        previousButton.setTitle("◀︎", for: UIControlState())
        previousButton.addTarget(self, action: #selector(EditViewController.toggleFirstResponder(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(EditViewController.toggleFirstResponder(_:)), for: .touchUpInside)
        nextButton.setTitle("▶︎", for: UIControlState())
        doneButton.setTitle("✓", for: UIControlState())
        doneButton.frame.origin.x = UIScreen.main.bounds.width-doneButton.frame.width
        doneButton.addTarget(self, action: #selector(EditViewController.dismissKeyboard), for: .touchUpInside)
        
        keyboardButtons.addSubview(previousButton)
        keyboardButtons.addSubview(nextButton)
        keyboardButtons.addSubview(doneButton)
        keyboardButtons.backgroundColor = UIColor.blue
        textFieldOne.inputAccessoryView = keyboardButtons
        textFieldTwo.inputAccessoryView = keyboardButtons
    }
    override func viewWillAppear(_ animated: Bool) {
        //try to add default values to textFields
        if (defaults.string(forKey: labelTextOne.text!) != nil){
            textFieldOne.text = defaults.string(forKey: labelTextOne.text!)!
        }else{
            textFieldOne.text = nil
        }
        if (defaults.string(forKey: labelTextTwo.text!) != nil){
            textFieldTwo.text = defaults.string(forKey: labelTextTwo.text!)!
        }else{
            textFieldTwo.text = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        //redraw textfield bottomborders if something changes
        bottomBorder.frame = CGRect(x: 0.0, y: textFieldOne.frame.size.height - 1, width: textFieldOne.frame.size.width, height: 1.0);
        bottomBorder2.frame = CGRect(x: 0.0, y: textFieldTwo.frame.size.height - 1, width: textFieldTwo.frame.size.width, height: 1.0);
    }
    
    @IBAction func saveValues(_ sender: UIButton) {
        var saveCounter = 0
        if (!textFieldOne.text!.isEmpty){
            defaults.set(textFieldOne.text!, forKey: labelTextOne.text!)
            saveCounter = 1
        }
        if (!textFieldTwo.text!.isEmpty){
            defaults.set(textFieldTwo.text!, forKey: labelTextTwo.text!)
            saveCounter += 2
        }
        saveResultLabel.isHidden = false
        switch saveCounter{
        case 1:
            saveResultLabel.text = String(format: NSLocalizedString("SAVE_TEXT_ONE", comment: "if only one new number is saved"), textFieldOne.text!,labelTextOne.text!)
        case 2:
            saveResultLabel.text = String(format: NSLocalizedString("SAVE_TEXT_TWO",comment: "if only text field two is saved"),textFieldTwo.text!,labelTextTwo.text!)
        case 3:
            saveResultLabel.text = String(format: NSLocalizedString("SAVED_VALUES", comment: "if new values were saved."))
        default:
            saveResultLabel.text = String(format: NSLocalizedString("NO_SAVED_VALUES",comment:"if no new values were saved"))
        }
    }
    
    @IBAction func restoreDefaults(_ sender: UIButton) {
        defaults.set(nil, forKey: labelTextOne.text!)
        defaults.set(nil, forKey: labelTextTwo.text!)
        textFieldOne.text = nil
        textFieldTwo.text = nil
        saveResultLabel.isHidden = false
        saveResultLabel.text = String(format: NSLocalizedString("VALUES_RESET",comment:"resetting to defaults"))
    }
    
    //only allow numbers and punctuation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let formatter = NumberFormatter()
        let formattedText = formatter.number(from: text)
        if (formattedText != nil || text.isEmpty){
            return true
        }else{
            return false
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
