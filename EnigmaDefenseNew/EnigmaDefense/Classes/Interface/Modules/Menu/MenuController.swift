//
//  MenuController.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit
import StoreKit

class MenuController: ViewController {

    var items: [MenuItem] = MenuItem.items
    
    private lazy var dismissButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layout.heightEqualTo(32)
        button.layout.widthEqualTo(32)
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(onDidDismissTapped), for: .touchUpInside)
        return button
    }()
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(MenuCell.self, forCellReuseIdentifier: MenuCell.stringIdentifier)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.layout.fillSuperview()
        // Do any additional setup after loading the view.
    }
    
    @objc func onDidDismissTapped() {
        
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

extension MenuController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.stringIdentifier) as! MenuCell
        cell.configure(icon: item.icon, title: item.type.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.items[indexPath.row]
        
        if item.type == .settings {
            let settingsVC = SettingsViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(settingsVC, animated: true)
        } else if item.type == .filters {
            let filterVC = FilterViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(filterVC, animated: true)
        } else if item.type == .term {
            if let termsOfUseURL = URL(string: Constants.termsOfUse) {
                UIApplication.shared.open(termsOfUseURL, options: [:], completionHandler: nil)
            }
        } else if item.type == .contact {
            if let termsOfUseURL = URL(string: Constants.contactSupport) {
                UIApplication.shared.open(termsOfUseURL, options: [:], completionHandler: nil)
            }
        } else if item.type == .rateus {
            SKStoreReviewController.requestReview()
        }
    }

}
