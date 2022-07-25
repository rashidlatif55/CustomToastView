

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
    case custom(Double)
}

public enum ToastGravity {
    case top
    case centre
    case bottom
}

public enum ToastStyle {
    case style_vibrant
}

protocol TostShowing{
    
    /// Present the Tost
    /// - Parameters:
    ///   - header: Title of tost
    ///   - message: Description of tost
    ///   - toastType: `ToastType` , success , error, warning, info
    ///   - duration: `ToastDuration` short, medium,  long and custom. Default will be medium
    ///   - toastGravity: `ToastGravity` top, center, bottom
    ///   - toastCornerRadius: default value is 10
    ///   - pulseEffect: Bool value, if its true it will animate the image view
    ///   - on: on which UIViewController, it will show under the Navigation controller of the UIViewController.
    func showTost(header: String, message: String,toastType: ToastType, duration: ToastDuration?, toastGravity: ToastGravity?, toastCornerRadius: Int?, pulseEffect: Bool?,on:UIViewController?)
}

extension TostShowing {
    
    func showTost(header: String, message: String,toastType: ToastType, duration: ToastDuration? = .medium, toastGravity: ToastGravity? = .top, toastCornerRadius: Int? = 10, pulseEffect: Bool? = false, on:UIViewController? = nil){
        
        var topBarHeight: CGFloat = 0
        var window: UIWindow?
        
        if #available(iOS 13.0, *) {
            guard let tempWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene})
                .compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first else { return }
            
            topBarHeight = (tempWindow.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + (on?.navigationController?.navigationBar.frame.height ?? 0.0)
            
            window = tempWindow
        } else {
            guard let tempWindow : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            
            topBarHeight = UIApplication.shared.statusBarFrame.size.height + (on?.navigationController?.navigationBar.frame.height ?? 0.0)
            
            window = tempWindow
        }
        
        var toastDuration = 2.0
        switch duration {
        case .short: toastDuration = 2.0;break
        case .medium: toastDuration = 3;break
        case .long: toastDuration = 4.0;break
        case .custom(let duration): toastDuration = duration
        case .none: break
            
        }
        
        guard let window = window else {return}
        
        var toastUIView: UIView?
        var gravity = CGRect(x: 0.0, y: window.frame.height - 130.0, width: window.frame.width, height: 83.0)
        switch toastGravity! {
        case .top: gravity = CGRect(x: 0.0, y: topBarHeight + 10, width: window.frame.width, height: 83.0);break
        case .centre: gravity = CGRect(x: 0.0, y: ((window.frame.height / 2) - 41) , width: window.frame.width, height: 83.0);break
        case .bottom: gravity = CGRect(x: 0.0, y: window.frame.height - 130.0, width: window.frame.width, height: 83.0);break
        }
        
        let toastView = ToastView(frame: gravity)
        if pulseEffect! { toastView.addPulseEffect() }
        toastView.toastContainerView.layer.cornerRadius = CGFloat(toastCornerRadius!)
        toastView.headLabel.text = header
        toastView.msgLabel.text = message
        toastView.applyStyle(toastType: toastType)
        
        toastUIView = toastView
        
        window.addSubview(toastUIView ?? UIView())
        
        var timer: Timer?
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(toastDuration), repeats: false, block: { timer in
            UIView.animate(withDuration: 0.5, animations: {
                toastUIView?.alpha = 0
            }) { (_) in
                toastUIView?.removeFromSuperview()
            }
        })
        
        toastUIView?.addTapGesture {
            toastUIView?.removeFromSuperview()
            timer?.invalidate()
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

extension UIView {
    
    func  addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}
