//
//  MotionToastView.swift
//  MotionToast
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

class ToastView: UIView {
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var circleImg: UIImageView!
    @IBOutlet weak var toastContainerView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet private weak var containerView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle(for: ToastView.self)
        let viewFromXib = bundle.loadNibNamed("ToastView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        circleView.layer.cornerRadius = circleView.bounds.size.width/2
    }
    
    func addPulseEffect() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.7
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        circleImg.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
    
    func applyStyle(toastType: ToastType) {
        self.headLabel.textColor = .tintSecondary
        self.msgLabel.textColor = .tintSecondary
        circleImg.tintColor = .tintSecondary
        
        self.toastContainerView.backgroundColor = .primary.withAlphaComponent(0.9)
        
        self.toastContainerView.layer.masksToBounds = true
        self.toastContainerView.layer.borderWidth = 2.0
        
        
        switch toastType {
        case .success:
            circleImg.image = UIImage(named: "tost.success.icon")!
            self.toastContainerView.layer.borderColor = UIColor.success.cgColor
            self.circleView.backgroundColor = .success
            
        case .error:
            circleImg.image = UIImage(named: "tost.error.icon")!
            self.toastContainerView.layer.borderColor = UIColor.error.cgColor
            self.circleView.backgroundColor = .error
            
        case .warning:
            circleImg.image = UIImage(named: "tost.warning.icon")!
            self.toastContainerView.layer.borderColor = UIColor.warning.cgColor
            self.circleView.backgroundColor = .warning
            
        case .info:
            circleImg.image = UIImage(named: "tost.info.icon")!
            self.toastContainerView.layer.borderColor = UIColor.information.cgColor
            self.circleView.backgroundColor = .information
        }
    }
    
}
