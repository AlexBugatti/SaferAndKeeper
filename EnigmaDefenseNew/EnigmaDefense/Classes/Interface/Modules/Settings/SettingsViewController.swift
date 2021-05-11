//
//  SettingsViewController.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit
import StoreKit

class SettingsViewController: ViewController {

    var items = SettingItem.settings
    
    private lazy var navigationBar: NavigationBar = {
        var bar = NavigationBar()
        return bar
    }()
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.register(ContainerCell.self, forCellReuseIdentifier: ContainerCell.stringIdentifier)
        view.register(UINib(nibName: ContentCell.stringIdentifier, bundle: nil), forCellReuseIdentifier: ContentCell.stringIdentifier)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.set(title: "Settings")
        navigationBar.didBackTapped = {
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        
        navigationBar.layout.leftEqualToSuperview()
        navigationBar.layout.rightEqualToSuperview()
        navigationBar.layout.topEqualTo(view.safeAreaLayoutGuide.topAnchor)
        navigationBar.layout.bottomEqualTo(tableView.topAnchor)
        navigationBar.layout.heightEqualTo(64)
        
        tableView.layout.leftEqualToSuperview()
        tableView.layout.rightEqualToSuperview()
        tableView.layout.bottomEqualToSuperview()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.stringIdentifier, for: indexPath) as! ContentCell
        let views = item.items.map { (it) -> UIView in
            let v = it.getView()
            return v
        }
        cell.configure(views: views)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = items[section]
        let view = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = Pallete.textColor
        label.text = item.title
        view.addSubview(label)
        label.layout.bottomEqualToSuperview(constant: -12)
        label.layout.leftEqualToSuperview(constant: 20)
        label.layout.rightEqualToSuperview(constant: -20)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = items[indexPath.section]
        let row = section.items[indexPath.row]
        if row.type == .termOfUse {
            if let termsOfUseURL = URL(string: Constants.termsOfUse) {
                UIApplication.shared.open(termsOfUseURL, options: [:], completionHandler: nil)
            }
        } else if row.type == .contactSupport {
            if let termsOfUseURL = URL(string: Constants.contactSupport) {
                UIApplication.shared.open(termsOfUseURL, options: [:], completionHandler: nil)
            }
        } else if row.type == .rateapp {
            SKStoreReviewController.requestReview()
        }
    }
    
}
