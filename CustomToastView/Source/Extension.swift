//
//  Extension.swift
//  MotionToast
//
//  Created by Sameer Nawaz on 10/08/20.
//  Copyright © 2020 Femargent Inc. All rights reserved.
//

import UIKit

public enum ToastType {
    case success
    case error
    case warning
    case info
}

public enum ToastDuration {
    case short
    case medium
    case long
}

public enum ToastGravity {
    case top
    case centre
    case bottom
}

public enum ToastStyle {
    case style_vibrant
}

extension UIViewController {
    
    func showTost(header: String, message: String,toastType: ToastType, duration: ToastDuration? = .medium, toastGravity: ToastGravity? = .top, toastCornerRadius: Int? = 10, pulseEffect: Bool? = false){
        
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            guard let tempWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene})
                .compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first else { return }
            window = tempWindow
        } else {
            guard let tempWindow : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            window = tempWindow
        }
        
        var toastDuration = 2.0
        switch duration {
        case .short: toastDuration = 2.0;break
        case .medium: toastDuration = 3;break
        case .long: toastDuration = 4.0;break
        case .none: break
        }
        
        var toastUIView: UIView?
            var gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0)
            switch toastGravity! {
            case .top: gravity = CGRect(x: 0.0, y: self.topbarHeight + 10, width: view.frame.width, height: 83.0);break
            case .centre: gravity = CGRect(x: 0.0, y: ((view.frame.height / 2) - 41) , width: view.frame.width, height: 83.0);break
            case .bottom: gravity = CGRect(x: 0.0, y: view.frame.height - 130.0, width: view.frame.width, height: 83.0);break
            }
            
            let toastView = ToastView(frame: gravity)
            if pulseEffect! { toastView.addPulseEffect() }
            toastView.toastContainerView.layer.cornerRadius = CGFloat(toastCornerRadius!)
            toastView.headLabel.text = header
            toastView.msgLabel.text = message
            toastView.applyStyle(toastType: toastType)
            
            toastUIView = toastView
            
       
        window?.addSubview(toastUIView!)
        
        UIView.animate(withDuration: 0.7, delay: toastDuration, animations: {
            toastUIView!.alpha = 0
        }) { (_) in
            toastUIView!.removeFromSuperview()
        }
        
        
    }
 
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
            return topBarHeight
        }
    }
}



extension UIColor {
    static let primary = UIColor(named: "Primary")!
    static let primaryDim = UIColor(named: "Primary-Dim")!
    
    static let secondary = UIColor(named: "Secondary")!
    static let secondaryDim = UIColor(named: "Secondary-Dim")!
    
    static let tertiary = UIColor(named: "Tertiary")!
    static let tertiaryDim = UIColor(named: "Tertiary-Dim")!
    
    static let tintPrimary = UIColor(named: "Tint-Primary")!
    static let tintPrimaryDim = UIColor(named: "Tint-Primary-Dim")!
    
    static let tintSecondary = UIColor(named: "Tint-Secondary")!
    static let tintSecondaryDim = UIColor(named: "Tint-Secondary-Dim")!
    
    static let tintTertiary = UIColor(named: "Tint-Tertiary")!
    static let tintTertiaryDim = UIColor(named: "Tint-Tertiary-Dim")!
    
    static let success = UIColor(named: "Success")!
    static let successDim = UIColor(named: "Success-Dim")!
    
    static let error = UIColor(named: "Error")!
    static let errorDim = UIColor(named: "Error-Dim")!
    
    static let warning = UIColor(named: "Warning")!
    static let warningDim = UIColor(named: "Warning-Dim")!
    
    static let information = UIColor(named: "Information")!
    static let informationDim = UIColor(named: "Information-Dim")!
    
    static let separator = UIColor(named: "Separator")!
    static let placeholder = UIColor(named: "Placeholder")!
    static let disabled = UIColor(named: "Disabled")!
    
    static let assetNeutral = UIColor(named: "asset-neutral")!
    static let assetLose = UIColor(named: "asset-lose")!
    static let assetGain = UIColor(named: "asset-gain")!
    
}
