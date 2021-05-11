//
//  ViewController.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit

class ViewController: UIViewController {

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            Pallete.topMainBackground.cgColor,
            Pallete.bottomMainBackground.cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        // Do any additional setup after loading the view.
    }


}

