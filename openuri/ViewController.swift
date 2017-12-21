//
//  ViewController.swift
//  openuri
//
//  Created by ipad_kid on 6/28/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputField: UITextField!
    private let defaults = UserDefaults.standard
    private let previous = "previous"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let previousInput = defaults.string(forKey: previous) else { return }
        inputField.text = previousInput
    }
    
    func openLink() -> Bool {
        guard let userInput = inputField.text, let urlString = URL(string: userInput) else { return false }
        
        let sharedApp = UIApplication.shared
        if sharedApp.canOpenURL(urlString) {
            if #available(iOS 10.0, *) {
                sharedApp.open(urlString, completionHandler: nil)
            } else {
                sharedApp.openURL(urlString)
            }
        } else {
            return false
        }
        
        defaults.set(userInput, forKey: previous)
        defaults.synchronize()
        inputField.resignFirstResponder()
        return true
    }
    
    @IBAction func doStuff() {
        _ = openLink()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return openLink()
    }
}
