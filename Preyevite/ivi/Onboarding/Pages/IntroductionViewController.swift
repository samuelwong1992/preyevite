//
//  IntroductionViewController.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

class IntroductionPrivacyViewController: UIViewController {

    static var viewController: IntroductionPrivacyViewController? {
        return StoryboardConstants.Storyboards.Onboarding.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.IntroductionPrivacyViewController.identifier) as? IntroductionPrivacyViewController
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        
        let descriptionText = NSMutableAttributedString(string: "After setting up ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        descriptionText.append(iviMutableText())
        descriptionText.append(NSMutableAttributedString(string: " for the first time, you will be shown a completely black, blank screen every time you open the app. Just swipe your password in and you'll be logged in. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        descriptionText.append(iviMutableText())
        descriptionText.append(NSMutableAttributedString(string: " uses 2FA by requiring your Face ID after a successful swipecode entry. This way, even if someone scopes your swipecode, they still wont be able to get it. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        descriptionText.append(iviMutableText())
        descriptionText.append(NSMutableAttributedString(string: " is a completely offline system. It does not backup data, nor can it be accessed from any device outside of your own. With that in mind, you can feel safe that your files cannot be leaked, but take care in that if you delete the app, you will lose the files too. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.attributedText = descriptionText
    }
    
    func iviMutableText() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: "ivi", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
    }
}
