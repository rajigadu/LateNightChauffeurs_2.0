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

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x:26, y: self.view.frame.size.height-100, width: self.view.frame.size.width - 54, height: 35))
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
