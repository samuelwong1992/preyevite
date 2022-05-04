//
//  LoginViewController.swift
//  ivi
//
//  Created by Samuel Wong on 11/4/22.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet var passwordTraceView: PasswordTraceView!
    
    var password: [StrokeDirection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTraceView._delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserHelpers.user == nil {
            if let vc = OnboardingViewController.viewController {
                vc.isModalInPresentation = true
                self.present(vc, animated: true, completion: nil)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(dismissViews), name: Notification.Name( NotificationConstants.Notifications.ReturnToLogin.name), object: nil)
    }
    
    @objc func dismissViews() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Password Trace View Delegate
extension LoginViewController: PasswordTraceViewDelegate {
    func passwordTraceView(passwordTraceView: PasswordTraceView, didSwipeWithDirection direction: StrokeDirection) {
        password.append(direction)
        
        guard UserHelpers.verifyPassword(input: password) else { return }
        let reason = "Confirm with biometrics."
        LAContext().evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

            if success {
                DispatchQueue.main.async { [unowned self] in
                    if let vc = MediaCollectionViewController.viewController {
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            } else {
                DispatchQueue.main.async { [unowned self] in
                    UIAlertController.showAlertWithError(viewController: self, errorString: "Face ID failed. Input your passcode again.")
                    self.password = []
                }
            }
        }

    }
}
