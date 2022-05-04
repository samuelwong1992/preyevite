//
//  HistoryViewController.swift
//  ivi
//
//  Created by Samuel Wong on 24/4/22.
//

import UIKit

class HistoryViewController: UIViewController {

    static var viewController: HistoryViewController? {
        return StoryboardConstants.Storyboards.Settings.storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllers.HistoryViewController.identifier) as? HistoryViewController
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
}

//MARK: Initialization
extension HistoryViewController {
    func initialize() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: Table View Delegate and Data Source
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistoryHelpers.historys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let history = HistoryHelpers.historys.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending })[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = history.title
        content.textProperties.color = history.getSeverity()?.colour ?? .black
        content.secondaryText = (history.note ?? "") + "\n" + (history.date?.timeDayMonthYearReadableString ?? "")
        cell.contentConfiguration = content
                
        return cell
    }
}
