//
//  SettingsViewController.swift
//  ivi
//
//  Created by Samuel Wong on 22/4/22.
//

import UIKit

class SettingsViewController: UIViewController {

    enum Settings: Int, CaseIterable {
        case History = 0
        case ResetPassword
        case ChangeIcon
        
        var title: String! {
            switch self {
            case .History : return "History"
            case .ResetPassword : return "Reset Password"
            case .ChangeIcon : return "Change Icon"
            }
        }
        
        var image: UIImage! {
            switch self {
            case .History : return UIImage(systemName: "clock.fill")
            case .ResetPassword : return UIImage(systemName: "lock.circle.fill")
            case .ChangeIcon : return UIImage(named: "eye-blue@3x")
            }
        }
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

}

//MARK: Initialzation
extension SettingsViewController {
    func initialize() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        closeButton.addTarget(self, action: #selector(closeButton_didPress), for: .touchUpInside)
    }
}

//MARK: Button Handlers
@objc extension SettingsViewController {
    func closeButton_didPress() {
        self.dismiss(animated: true)
    }
}

//MARK: Table View Delegate and Data Source
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let setting = Settings.allCases[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = setting.title
        content.image = setting.image
        content.imageProperties.maximumSize = CGSize(width: 24, height: 24)
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = Settings.allCases[indexPath.row]
        
        switch setting {
        case .History :
            if let vc = HistoryViewController.viewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .ResetPassword :
            if let vc = OnboardingViewController.viewController {
                vc.isModalInPresentation = true
                self.present(vc, animated: true, completion: nil)
            }
        case .ChangeIcon :
            if let vc = SelectLogoViewController.viewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
