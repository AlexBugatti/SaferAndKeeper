//
//  PasswordsViewController.swift
//  MiSecure
//
//  Created by Александр on 10.05.2021.
//

import UIKit

class PasswordsViewController: UIViewController {

    var passwords: [Password] = PasswordStorage.shared.getPasswords() {
        didSet {
            self.tableView?.reloadData()
            self.placeholderLabel?.isHidden = passwords.count > 0
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib.init(nibName: "PasswordsCell", bundle: nil), forCellReuseIdentifier: "PasswordsCell")
        }
    }
    @IBOutlet weak var addPasswordButton: UIButton! {
        didSet {
            self.addPasswordButton.layer.cornerRadius = addPasswordButton.frame.width / 2
            self.addPasswordButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 20
            self.containerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var borderView: UIView! {
        didSet {
            self.borderView.layer.borderWidth = 4
            self.borderView.layer.cornerRadius = 20
            self.borderView.layer.borderColor = UIColor(hexString: "#78788C").cgColor
        }
    }
    
    @IBOutlet weak var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeholderLabel?.isHidden = passwords.count > 0
        // Do any additional setup after loading the view.
    }

    @IBAction func onDidCreatePassword(_ sender: Any) {
        if PinService.shared.isPincodeInstalled == false {
            let alert = UIAlertController(title: "Master code", message: "Please set master code for use password keeper", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default) { action in
                let vc = InputPinViewController(state: .first)
                vc.didSendPincode = { pincode in
                    PinService.shared.setPin(code: pincode)
                    vc.dismiss(animated: true, completion: nil)
                    self.showCreatePasswordPopup()
                }
                self.present(vc, animated: true, completion: nil)
            }
            let cancel = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
            alert.addAction(cancel)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            showCreatePasswordPopup()
        }
    }
    
    func showCreatePasswordPopup() {
        let alertController = UIAlertController(title: "Add New Password", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Label"
        }
        let saveAction = UIAlertAction(title: "Keep", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            guard let label = firstTextField.text, let password = secondTextField.text else {
                return
            }
            
            if label.isEmpty == false, password.isEmpty == false {
                let password = Password(label: label, password: password, date: Int(Date().timeIntervalSince1970))
                PasswordStorage.shared.create(password: password)
                self.passwords = PasswordStorage.shared.getPasswords()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Password"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func isNeedInputPin(password: Password) {
//
//        if PinService.shared.isPincodeInstalled == false {
//            let alert = UIAlertController(title: "Enter new master code", message: nil, preferredStyle: .alert)
//            let okAction = UIAlertAction.init(title: "Ok", style: .default) { action in
//                let vc = InputPinViewController(state: .first)
//                vc.didSendPincode = { pincode in
//                    PinService.shared.setPin(code: pincode)
//                }
//                self.present(vc, animated: true, completion: nil)
//            }
//            let cancel = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
//            alert.addAction(okAction)
//            alert.addAction(cancel)
//            self.present(alert, animated: true, completion: nil)
//        } else {
//            PasswordStorage.shared.create(password: password)
//            self.passwords = PasswordStorage.shared.getPasswords()
//        }
//    }
    
    func showPinController(password: Password) {
        if PinService.shared.isPincodeInstalled {
            let showVC = InputPinViewController(state: .auth)
            showVC.didAuthAttempt = { str in
                showVC.dismiss(animated: true, completion: nil)
                if PinService.shared.check(code: str) {
                    let alert = UIAlertController(title: "Password", message: password.password, preferredStyle: .alert)
                    let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error master code", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            self.present(showVC, animated: true, completion: nil)
        } else {
//            let showVC = InputPinViewController(state: .first)
//            showVC.didAuthAttempt = { str in
//            }
//            self.present(showVC, animated: true, completion: nil)
        }
        
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

extension PasswordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let password = self.passwords[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordsCell", for: indexPath) as! PasswordsCell
        cell.didShowTapped = {
            self.showPinController(password: password)
        }
        cell.titleLabel.text = password.label
        return cell
    }

}
