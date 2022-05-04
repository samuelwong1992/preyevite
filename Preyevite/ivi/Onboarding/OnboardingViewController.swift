//
//  OnboardingViewController.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    static var viewController: OnboardingViewController? {
        return StoryboardConstants.Storyboards.Onboarding.storyboard.instantiateInitialViewController() as? OnboardingViewController
    }
    
    var pageViewController: OnboardingPageViewController?
    
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension OnboardingViewController {
    func initialize() {
        nextButton.addTarget(self, action: #selector(nextButton_didPress), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OnboardingPageViewController {
            pageViewController = vc
            if let scrollView = pageViewController?.view.subviews.filter({$0.isKind(of: UIScrollView.self)}).first as? UIScrollView {
                scrollView.isScrollEnabled = false
            }

        }
    }
}

//MARK: Button Handlers
@objc extension OnboardingViewController {
    func nextButton_didPress() {
        if pageViewController?.index == 2 {
            if let setupVC = pageViewController?.viewControllers?.last as? SetupPasswordViewController {
                if setupVC.password.count > 0 {
                    if let vc = ConfirmPasswordViewController.viewController {
                        vc.password = setupVC.password
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    UIAlertController.showAlertWithError(viewController: setupVC, errorString: "The password must at least be one swipe in length")
                }
            }
        } else {
            pageViewController?.index += 1
            if pageViewController?.index == 2 {
                nextButton.setTitle("Finish", for: .normal)
            }
        }
    }
}
