//
//  IntroductionSettingsViewController.swift
//  ivi
//
//  Created by Samuel Wong on 10/5/2022.
//

import UIKit

class IntroductionSettingsViewController: UIViewController {

    static var viewController: IntroductionSettingsViewController? {
        return StoryboardConstants.Storyboards.Onboarding.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.IntroductionSettingsViewController.identifier) as? IntroductionSettingsViewController
    }
    
    @IBOutlet weak var featureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        
        let featureText = NSMutableAttributedString(string: "Extra options can be given to your files by long pressing them. Thumbnails can be blurred or files permanently deleted. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        featureText.append(iviMutableText())
        featureText.append(NSMutableAttributedString(string: " also allows you to change its icon to be something more discreet in the options. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        featureText.append(iviMutableText())
        featureText.append(NSMutableAttributedString(string: " will also record any misused actions during the use of the app so you can see if there is suspicious activity. Any incorrect passcodes or screenshots taken will be recorded in the History section of the settings. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        featureText.append(iviMutableText())
        featureText.append(NSMutableAttributedString(string: " will require swipecode access on every open, so don't worry about closing the windows before closing the app. ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        
        featureLabel.textColor = UIColor.white
        featureLabel.attributedText = featureText
    }
    
    func iviMutableText() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: "ivi", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
    }
}
