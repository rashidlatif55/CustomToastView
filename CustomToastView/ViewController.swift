//
//  ViewController.swift
//  CustomToastView
//
//  Created by Rashid Latif on 22/07/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showTost(header: "Custom Toast", message: "It gives you more customisation you more customisation optionsgives you more customisation optionsgives you more customisation options.", toastType: .error, duration: .long)
        }
    }


}

