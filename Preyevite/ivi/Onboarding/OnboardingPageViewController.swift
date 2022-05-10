//
//  OnboardingPageViewController.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    enum ViewControllers: CaseIterable {
        case Welcome
        case IntroductionPrivacy
        case IntroductionSettings
        case SetupPassword
        
        var viewController: UIViewController? {
            switch self {
            case .Welcome: return WelcomeViewController.viewController
            case .IntroductionPrivacy: return IntroductionPrivacyViewController.viewController
            case .IntroductionSettings: return IntroductionSettingsViewController.viewController
            case .SetupPassword: return SetupPasswordViewController.viewController
            }
        }
    }
    
    var _viewControllers: [UIViewController] = []
    
    var index = 0 {
        didSet {
            if index < _viewControllers.count {
                self.setViewControllers([_viewControllers[index]], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension OnboardingPageViewController {
    func initialize() {
        self.view.backgroundColor = .black
        _viewControllers = []
        
        for viewControllerCase in ViewControllers.allCases {
            if let vc = viewControllerCase.viewController {
                _viewControllers.append(vc)
            }
        }
        
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([_viewControllers.first!], direction: .forward, animated: false, completion: nil)
    }
}

extension OnboardingPageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = _viewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return _viewControllers.last }
        guard _viewControllers.count > previousIndex else { return nil }

        return _viewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = _viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < _viewControllers.count else { return _viewControllers.first }
        guard _viewControllers.count > nextIndex else { return nil }

        return _viewControllers[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return _viewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first else { return 0 }
        guard let firstVCIndex = _viewControllers.firstIndex(of: firstVC) else { return 0 }

        return firstVCIndex
    }
}
