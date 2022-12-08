//
//  helperConstants.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire
import SideMenu
extension UIViewController {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
extension UIViewController {
    
    func moveToLogOutPage() {
        UserDefaults.standard.set("", forKey: "UserLoginID")
        UserDefaults.standard.set("", forKey: "RideRequestProcessingCheck")
        UserDefaults.standard.set("", forKey: "CurrentNotificationTitle")
        UserDefaults.standard.set("", forKey: "SelectedCardDetails")
        self.resetDefaults()
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.MoveToLogin()
        }
    }

func showToast(message : String, font: UIFont) {
    self.ShowAlert(message: message)
//    let toastLabel = UILabel(frame: CGRect(x:26, y: self.view.frame.size.height-100, width: self.view.frame.size.width - 54, height: 35))
//    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//    toastLabel.textColor = UIColor.white
//    toastLabel.font = font
//    toastLabel.textAlignment = .center;
//    toastLabel.text = message
//    toastLabel.alpha = 1.0
//    toastLabel.layer.cornerRadius = 10;
//    toastLabel.clipsToBounds  =  true
//    self.view.addSubview(toastLabel)
//    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
//         toastLabel.alpha = 0.0
//    }, completion: {(isCompleted) in
//        toastLabel.removeFromSuperview()
//    })
}
    func showToast2(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x:26, y: self.view.frame.size.height/2, width: self.view.frame.size.width - 54, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

class indicator {
    class  func showActivityIndicator(){
        let KAppDelegate = UIApplication.shared.delegate as! AppDelegate
        var downloading = MBProgressHUD()
        downloading = MBProgressHUD(view: (KAppDelegate.window?.rootViewController?.view.window!)!)
        KAppDelegate.window!.addSubview(downloading)
        downloading.label.text = "Loading"
        downloading.show(animated: true)
    }
    class func hideActivityIndicator(){
         DispatchQueue.main.async {
         let KAppDelegate = UIApplication.shared.delegate as! AppDelegate
         MBProgressHUD.hide(for: (KAppDelegate.window?.rootViewController?.view.window!)!, animated: true)
        }
    }
    
}
class Connectivity {
    static var isNotConnectedToInternet:Bool{
        return !NetworkReachabilityManager()!.isReachable
    }
}
extension UIViewController {

    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }

    func dismissHUD(isAnimated:Bool) {
       
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}

extension UIViewController {
func json(from object:Any) -> String? {
       guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
           return nil
       }
       return String(data: data, encoding: String.Encoding.utf8)
   }
}
extension UIViewController {
   
     func ShowAlert(message : String){
        let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
     }
    
    func ShowAlertWithPop(message : String){
        let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.popToBackVC()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func ShowAlertWithDismiss(message : String){
           let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
               self.dismiss()
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
    
    func ShowAlertWithPUSH(message : String,id:String,storyBordid : String,animated:Bool?){
        let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.movetonextvc(id:id,storyBordid : storyBordid,animated:animated)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func ShowAlertWithLoginPage(message : String){
           let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
               self.MoveToLoginPage()
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
    
    func MoveToLoginPage() {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)

                                let loginVC = Storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let window = UIApplication.shared.windows.first

        let nav = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = nav

    }
    func ShowAlertWithDashBoardPage(message : String){
           let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
               self.MoveToDashBoardPage()
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
    func MoveToDashBoardPage() {
        let Storyboard : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)

                                let loginVC = Storyboard.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        let window = UIApplication.shared.windows.first

        let nav = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = nav

    }
    
    func ShowAlertWithRideInfoPage(message : String){
           let alertController = UIAlertController(title: kApptitle, message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
               self.MoveToRideInfoPage()
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
       }
    func MoveToRideInfoPage() {
        let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)

                                let loginVC = Storyboard.instantiateViewController(withIdentifier: "RideHistoryViewController") as! RideHistoryViewController
        let window = UIApplication.shared.windows.first

        let nav = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = nav

    }
}
extension UIViewController {
    func movetonextvc(id:String,storyBordid : String,animated:Bool?){
        let Storyboard : UIStoryboard = UIStoryboard(name: storyBordid, bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(nxtVC, animated: animated ?? true)
    }
    func presentnextvc(id:String,storyBordid : String,animated:Bool){
        let Storyboard : UIStoryboard = UIStoryboard(name: storyBordid, bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: id)
        nxtVC.modalPresentationStyle = .fullScreen
        self.present(nxtVC, animated: animated)
    }
    func popToBackVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToSideMenu(){
        let Storyboard : UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = SideMenuNavigationController(rootViewController: nxtVC)
        menu.leftSide = true
        present(menu, animated: true, completion: nil)
    }

    
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func swipeRight(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                self.navigateToSideMenu()
            case .down:
                print("Swiped down")
            case .left:
                print("Swiped left")
                
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func uiAnimate(view : NSLayoutConstraint, Constratint : Float){
        UIView.animate(withDuration:0.2, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
            view.constant = CGFloat(Constratint)
              self.view.layoutIfNeeded()
          }, completion: nil)
    }
    
    func show(_ view : UIViewController) {
           let win = UIWindow(frame: UIScreen.main.bounds)
           let vc = view
           vc.view.backgroundColor = .clear
           win.rootViewController = vc
           win.windowLevel = UIWindow.Level.alert + 1  // Swift 3-4: UIWindowLevelAlert + 1
           win.makeKeyAndVisible()
           vc.present(self, animated: true, completion: nil)
       }
  
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}

extension UIViewController {
    func numberOfSections_nodata(in tableView: UITableView,ArrayCount : Int,numberOfsections : Int,data_MSG_Str : String) -> Int
    {
        
        var numOfSections: Int = 0
        if (ArrayCount != 0)
        {
            tableView.separatorStyle = .none
            numOfSections            = numberOfsections
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = data_MSG_Str
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
}
extension UITableView {

    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
extension UIViewController {
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}

extension UIViewController {

func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    if let date = inputFormatter.date(from: dateString) {

        let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = format

        return outputFormatter.string(from: date)
    }

    return nil
}
}
extension String {
   func replace(string:String, replacement:String) -> String {
       return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
   }

   func removeWhitespace() -> String {
       return self.replace(string: " ", replacement: "+")
   }
 }

extension UIViewController {
    
    func formattedDateFromString2(inputDatestr : String,dateString: String, withFormat format: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputDatestr//"yyyy-MM-dd HH:mm:ss"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        return dateString
    }
}

extension UIView {
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
extension UIViewController {
    @objc func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    override func topMostViewController() -> UIViewController {
        return self.selectedViewController!.topMostViewController()
    }
}

extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        return self.visibleViewController!.topMostViewController()
    }
}
