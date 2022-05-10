//
//  StoryboardConstants.swift
//  ivi
//
//  Created by Samuel Wong on 12/4/22.
//

import UIKit

struct StoryboardConstants {
    enum Storyboards: String {
        case Onboarding = "Onboarding"
        case MediaCollection = "MediaCollection"
        case Settings = "Settings"
        
        var storyboard: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }
    
    enum ViewControllers: String {
        case WelcomeViewController = "WelcomeViewController"
        case IntroductionPrivacyViewController = "IntroductionPrivacyViewController"
        case IntroductionSettingsViewController = "IntroductionSettingsViewController"
        case SetupPasswordViewController = "SetupPasswordViewController"
        case ConfirmPasswordViewController = "ConfirmPasswordViewController"
        case MediaViewController = "MediaViewController"
        case MediaPageViewController = "MediaPageViewController"
        case HistoryViewController = "HistoryViewController"
        case SelectLogoViewController = "SelectLogoViewController"
        
        var identifier: String {
            return self.rawValue
        }
    }
    
    enum Segues: String {
        case OnboardingPageView = "OnboardingPageView"
        
        var identifier: String {
            return self.rawValue
        }
    }
    
    enum Nibs: String {
        case ImageCollectionViewCell = "ImageCollectionViewCell"
        case SettingsTableViewCell = "SettingsTableViewCell"
        
        var identifier: String {
            return self.rawValue
        }
    }
}
