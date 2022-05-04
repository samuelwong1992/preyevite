//
//  UIAlertController + Utilities.swift
//  ivi
//
//  Created by Samuel Wong on 14/4/22.
//

import UIKit

extension UIAlertController {
    static func showAlertWithError(viewController:UIViewController, error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithError(viewController:UIViewController, errorString: String) {
        let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithErrorNoDismiss(viewController:UIViewController, errorString: String) {
        let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithWarning(viewController:UIViewController, warningString: String, customCompletion: ((UIAlertAction) -> Void)? = nil) {
        let string = NSAttributedString(string: "WARNING", attributes:([NSAttributedString.Key.foregroundColor : UIColor.red]))
        let alert = UIAlertController(title: "", message: warningString, preferredStyle: .alert)
        alert.setValue(string, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: customCompletion))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithOk(viewController:UIViewController, titleString: String, messageString: String, customCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: customCompletion))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func createAlertWithError(error: Error) -> UIAlertController {
           let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           return alert
    }
    
    static func createAlertWithError(errorString: String) -> UIAlertController {
           let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           return alert
    }
    
    static func createAlertWithNoAction(titleString: String, messageString: String) -> UIAlertController {
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        return alert
    }
    
    static func createAlertWithCancelAction(titleString: String, messageString: String) -> UIAlertController {
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
}
