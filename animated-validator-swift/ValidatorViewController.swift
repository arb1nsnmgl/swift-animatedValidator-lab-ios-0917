//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    var status = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        submitButton.alpha = 0.0
        submitButton.isEnabled = false
        status = [0,0,0,0,0]
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        status[textField.tag] = 0
        submitButton.isEnabled = !(status.contains(0))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text == "" { textField.tintNormal(); return }
        validate(textField: textField.tag)
        if !(status.contains(0)) { enableButton() }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validate(textField withTag: Int) {
       
        switch withTag {
            
        case 0:
            if !self.emailTextField.validateContentsOf(email: emailTextField.text!)  {
                emailTextField.flash()
                emailTextField.shake()
            } else { status[emailTextField.tag] = 1 }
            
        case 1:
            if self.emailConfirmationTextField.text != self.emailTextField.text {
                emailConfirmationTextField.tintInvalid()
                emailConfirmationTextField.flash()
                emailConfirmationTextField.shake()
            } else {
                emailConfirmationTextField.tintValid()
                status[emailConfirmationTextField.tag] = 1
            }
        
        case 2:
            if !self.phoneTextField.validateContentsOf(phone: phoneTextField.text!) {
                phoneTextField.shake()
                phoneTextField.flash()
            } else { status[phoneTextField.tag] = 1 }
            
        case 3:
            if !self.passwordTextField.validateContentsOf(password: passwordTextField.text!) {
                passwordTextField.flash()
                passwordTextField.shake()
            } else { status[passwordTextField.tag] = 1 }
            
        case 4:
            if self.passwordConfirmTextField.text != self.passwordTextField.text {
                passwordConfirmTextField.tintInvalid()
                passwordConfirmTextField.flash()
                passwordConfirmTextField.shake()
            } else {
                passwordConfirmTextField.tintValid()
                status[passwordConfirmTextField.tag] = 1
            }
            
        default: break
        
        }
        
    }
    
    func enableButton() {
        
        self.submitButton.center.x = self.view.frame.width + 50
        submitButton.isEnabled = !(status.contains(0))
        
        if submitButton.isEnabled {
            UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 30, options: .curveEaseInOut, animations: ({
                
                self.submitButton.alpha = 1.0
                self.submitButton.center.x = self.view.frame.width / 2
                
            }), completion: nil)
        }
    }
    
}

extension UITextField {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.5
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -5.0, 3.0, 0.0]
        layer.add(animation, forKey: "shake")
    }
    
    func flash() {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.8
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
    func tintInvalid() {
        let red = UIColor(red: 209/255.0, green: 29/255.0, blue: 16/255.0, alpha: 0.5)
        self.layer.borderColor = red.cgColor
        self.layer.borderWidth = 3.0
    }
    
    func tintValid() {
        let blue = UIColor(red: 16/255.0, green: 148/255.0, blue: 209/255.0, alpha: 0.5)
        self.layer.borderColor = blue.cgColor
        self.layer.borderWidth = 3.0
    }
    
    func tintNormal() {
        let clear = UIColor.clear
        self.layer.borderColor = clear.cgColor
    }
    
    
    func validateContentsOf(email text: String) -> Bool {
        
        if (self.text?.characters.contains("@"))! && (self.text?.characters.contains("."))! {
            self.tintValid()
            return true }
        self.tintInvalid()
        return false
    }
    
    func validateContentsOf(password text: String) -> Bool {
        
        if (self.text?.characters.count)! >= 7 {
            self.tintValid()
            return true }
        self.tintInvalid()
        return false
    }
    
    func validateContentsOf(phone text: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        if phoneTest.evaluate(with: text) {
            self.tintValid()
            return true }
        self.tintInvalid()
        return false
        
    }
}
