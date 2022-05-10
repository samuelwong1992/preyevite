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
    
    @IBOutlet weak var passwordTraceView: PasswordTraceView!
    @IBOutlet weak var passwordDescriptionLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
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
        self.view.backgroundColor = Theme.Colours.Black.uiColor
        
        passwordTraceView._delegate = self
        passwordTraceView._dataSource = self
        passwordTraceView.addBorder(withColor: Theme.Colours.White.uiColor.cgColor)
        
        passwordDescriptionLabel.textColor = Theme.Colours.White.uiColor
        passwordTitleLabel.textColor = Theme.Colours.White.uiColor
        passwordLabel.textColor = Theme.Colours.White.uiColor
        
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
