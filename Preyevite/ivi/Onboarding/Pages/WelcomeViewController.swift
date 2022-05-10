//
//  WelcomeViewController.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    static var viewController: WelcomeViewController? {
        return StoryboardConstants.Storyboards.Onboarding.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.WelcomeViewController.identifier) as? WelcomeViewController
    }
    
    @IBOutlet var leftTextLabel: UILabel!
    @IBOutlet var middleTextLabel: UILabel!
    @IBOutlet var rightTextLabel: UILabel!
        
    @IBOutlet var imageViewWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var leftTextWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var middleTextWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var rightTextWidthLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveEaseInOut) {
                self.imageViewWidthLayoutConstraint.constant = 120
                
                self.leftTextLabel.alpha = 0
                self.rightTextLabel.alpha = 0
                
                self.view.layoutIfNeeded()
            } completion: { finished in
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut) {
                    self.subtitleLabel.alpha = 1
                }
            }
        }
    }
}

//MARK: Initialization
extension WelcomeViewController {
    func initialize() {
        self.subtitleLabel.alpha = 0
    }
}
