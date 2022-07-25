//
//  ViewController.swift
//  CustomToastView
//
//  Created by Rashid Latif on 22/07/2022.
//

import UIKit

class ViewController: UIViewController, TostShowing {

    override func viewDidLoad() {
        super.viewDidLoad()
         
    }


    @IBAction private func showTost(_ sender: UIButton){
        self.showTost(header: "Custom Toast header", message: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", toastType: .error, duration: .custom(2))
    }
}

