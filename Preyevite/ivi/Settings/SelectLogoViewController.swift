//
//  SelectLogoViewController.swift
//  ivi
//
//  Created by Samuel Wong on 26/4/22.
//

import UIKit

class SelectLogoViewController: UIViewController {

    static var viewController: SelectLogoViewController? {
        return StoryboardConstants.Storyboards.Settings.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.SelectLogoViewController.identifier) as? SelectLogoViewController
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension SelectLogoViewController {
    func initialize() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: UITableView Delegate and Data Source
extension SelectLogoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Icons.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let icon = Icons(rawValue: indexPath.row)!
        
        var content = cell.defaultContentConfiguration()
        content.text = icon.title
        content.image = icon.previewImage
        cell.contentConfiguration = content

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let icon = Icons(rawValue: indexPath.row)!
        if icon == .Eye {
            UIApplication.shared.setAlternateIconName(nil)
        } else {
            UIApplication.shared.setAlternateIconName(icon.name) { error in
                if let error = error {
                    print("Error setting alternate icon \(icon.name): \(error.localizedDescription)")
                }
            }
        }
    }
}
