//
//  VPNCountriesController.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit

class VPNCountriesController: UIViewController {

    var didCountrySelected: ((VPNCountry) -> Void)?
    var filterCountries: [VPNCountry] {
        let countries = VPNCountry.coutries()
        return countries.filter { (country) -> Bool in
            if isFavorite {
                return country.isFavorite == true
            } else {
                return true
            }
        }
    }
    var isFavorite: Bool = false {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        var view = UITableView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.register(UINib(nibName: CountryCell.stringIdentifier, bundle: nil), forCellReuseIdentifier: CountryCell.stringIdentifier)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VPNCountriesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCountries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = self.filterCountries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.stringIdentifier, for: indexPath) as! CountryCell
        cell.configure(country: country)
        cell.onDidSelectTapped = {
            let country = self.filterCountries[indexPath.row]
            self.didCountrySelected?(country)
        }
        cell.onDidFavoriteTapped = {
            country.isFavorite = !country.isFavorite
            self.tableView.reloadData()
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let country = self.countries[indexPath.row]
//        self.didCountrySelected?(country)
//    }
    
}
