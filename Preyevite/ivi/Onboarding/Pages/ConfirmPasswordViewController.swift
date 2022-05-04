//
//  ConfirmPasswordViewController.swift
//  ivi
//
//  Created by Samuel Wong on 19/4/22.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {
    
    static var viewController: ConfirmPasswordViewController? {
        return StoryboardConstants.Storyboards.Onboarding.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.ConfirmPasswordViewController.identifier) as? ConfirmPasswordViewController
    }
    
    @IBOutlet var passwordTraceView: PasswordTraceView!
    @IBOutlet var cancelButton: SoftButton!
    @IBOutlet var confirmButton: PrimaryButton!
        
    var password: [StrokeDirection]!
    var confirmationInput: [StrokeDirection] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension ConfirmPasswordViewController {
    func initialize() {
        confirmButton.isHidden = true
        passwordTraceView._delegate = self
        
        confirmButton.addTarget(self, action: #selector(confirmButton_didPress), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButton_didPress), for: .touchUpInside)
    }
}

//MARK: Password Trace View Delegate
extension ConfirmPasswordViewController: PasswordTraceViewDelegate {
    func passwordTraceView(passwordTraceView: PasswordTraceView, didSwipeWithDirection direction: StrokeDirection) {
        confirmationInput.append(direction)
        confirmButton.isHidden = !UserHelpers.verifyPassword(input: confirmationInput, password: password)
    }
}

//MARK: Button Handlers
@objc extension ConfirmPasswordViewController {
    func cancelButton_didPress() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func confirmButton_didPress() {
        guard UserHelpers.verifyPassword(input: confirmationInput, password: password) else { return }
        let userTuple = UserHelpers.createUser(withPassword: password)
        
        guard userTuple.error == nil else { print(userTuple.error!); return }
        guard userTuple.user != nil else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name(NotificationConstants.Notifications.ReturnToLogin.name), object: nil)
    }
}
