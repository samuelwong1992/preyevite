//
//  SetupPasswordViewController.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

class SetupPasswordViewController: UIViewController {

    static var viewController: SetupPasswordViewController? {
        return StoryboardConstants.Storyboards.Onboarding.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.SetupPasswordViewController.identifier) as? SetupPasswordViewController
    }
    
    @IBOutlet var passwordTraceView: PasswordTraceView!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var clearButton: UIButton!
    
    var password: [StrokeDirection] = [] {
        didSet {
            var passwordText = ""
            for direction in password {
                passwordText += direction.title + ", "
            }
            if passwordText.count > 2 {
                passwordText.removeLast(2)
            }
            passwordLabel.text = passwordText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension SetupPasswordViewController {
    func initialize() {
        passwordTraceView._delegate = self
        passwordTraceView._dataSource = self
        
        clearButton.addTarget(self, action: #selector(clearButton_didPress), for: .touchUpInside)
    }
}

//MARK: Button Handlers
@objc extension SetupPasswordViewController {
    func clearButton_didPress() {
        password = []
    }
}

//MARK: Trace View Delegate and Data Source
extension SetupPasswordViewController: PasswordTraceViewDelegate, PasswordTraceViewDataSource {
    func passwordTraceView(passwordTraceView: PasswordTraceView, didSwipeWithDirection direction: StrokeDirection) {
        password.append(direction)
    }
    
    func shouldShowTrace(forPasswordTraceView passwordTraceView: PasswordTraceView) -> Bool {
        return true
    }
}
