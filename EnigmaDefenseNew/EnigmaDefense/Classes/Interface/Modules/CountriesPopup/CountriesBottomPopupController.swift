//
//  CountriesBottomPopupController.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit
import BottomPopup
import SwipeMenuViewController

class CountriesBottomPopupController: BottomPopupViewController {

    var didCountryTapped: ((VPNCountry) -> Void)?
    override var popupTopCornerRadius: CGFloat {
        return 32
    }
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = Pallete.accentColor
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
        return lineView
    }()
    private lazy var allButton: UIButton = {
        let all = UIButton()
        all.setTitle("All", for: .normal)
        all.setTitleColor(.white, for: .selected)
        all.setTitleColor(Pallete.textColor, for: .normal)
        all.addTarget(self, action: #selector(onDidSelectTapped(sender:)), for: .touchUpInside)
        return all
    }()
    private lazy var favoriteButton: UIButton = {
        let favorite = UIButton()
        favorite.setTitle("Favorite", for: .normal)
        favorite.setTitleColor(.white, for: .selected)
        favorite.setTitleColor(Pallete.textColor, for: .normal)
        favorite.tag = 1
        favorite.addTarget(self, action: #selector(onDidSelectTapped(sender:)), for: .touchUpInside)
        return favorite
    }()
    private lazy var swipeMenu: UIView = {
        var view = UIView()

        view.addSubview(allButton)
        view.addSubview(favoriteButton)
        
        allButton.layout.leftEqualToSuperview(constant: 20)
        allButton.layout.centerVertically()
        favoriteButton.layout.leftEqualTo(allButton.rightAnchor, constant: 20)
        favoriteButton.layout.centerVertically()
        
        return view
    }()
    private lazy var countryController: VPNCountriesController = {
        var vc = VPNCountriesController(nibName: nil, bundle: nil)
        return vc
    }()
    var controllers = [UIViewController(), ViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
        self.view.addSubview(swipeMenu)
        swipeMenu.layout.leftEqualToSuperview()
        swipeMenu.layout.topEqualToSuperview()
        swipeMenu.layout.rightEqualToSuperview()
        swipeMenu.layout.heightEqualTo(66)
        
        let popupArrow = UIImageView.init()
        popupArrow.image = UIImage(named: "bottom-popup-arrow")
        popupArrow.layout.widthEqualTo(28)
        popupArrow.layout.heightEqualTo(4)
        swipeMenu.addSubview(popupArrow)
        popupArrow.layout.topEqualTo(swipeMenu.topAnchor, constant: 8)
        popupArrow.layout.centerHorizontally()
        
        let separateView = UIView()
        separateView.backgroundColor = Pallete.separateColor
        swipeMenu.addSubview(separateView)
        separateView.layout.heightEqualTo(0.5)
        separateView.layout.leftEqualToSuperview()
        separateView.layout.rightEqualToSuperview()
        separateView.layout.bottomEqualToSuperview()
        
        self.addChild(countryController)
        self.view.addSubview(countryController.view)
        countryController.view.layout.leftEqualToSuperview()
        countryController.view.layout.rightEqualToSuperview()
        countryController.view.layout.topEqualTo(swipeMenu.bottomAnchor)
        countryController.view.layout.bottomEqualToSuperview()
        countryController.didMove(toParent: self)
        
        self.view.addSubview(lineView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.lineView.frame = CGRect(x: self.allButton.frame.minX, y: self.allButton.frame.maxY, width: self.allButton.frame.width, height: 2)
        }
        
        countryController.didCountrySelected = { country in
            self.didCountryTapped?(country)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @objc func onDidSelectTapped(sender: UIButton) {
        favoriteButton.isSelected = false
        allButton.isSelected = false
        sender.isSelected = true
        if sender.tag == 1 {
            countryController.isFavorite = true
        } else {
            countryController.isFavorite = false
        }
        UIView.animate(withDuration: 0.2) {
            self.lineView.frame = CGRect(x: sender.frame.minX, y: sender.frame.maxY, width: sender.frame.width, height: 2)
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

extension CountriesBottomPopupController: SwipeMenuViewDelegate, SwipeMenuViewDataSource {
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        return controllers[index]
    }
    
    
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return "all"
    }
    
    
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return controllers.count
    }

}
