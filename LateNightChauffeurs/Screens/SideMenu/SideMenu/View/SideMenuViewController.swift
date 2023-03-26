//
//  SideMenuViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 09/09/22.
//

import UIKit
import SideMenu
class SideMenuViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var lbl_UserNameRef: UILabel!
    @IBOutlet weak var lbl_EmailRef: UILabel!
    @IBOutlet weak var view_BackgroundRef: UIView!
    @IBOutlet weak var lbl_AverageRatingRef: UILabel!
    @IBOutlet weak var imageview_ProfileRef: UIImageView!
    @IBOutlet weak var tableview_MenuSliderRef: UITableView!

    //MARK: - Class Propeties
    lazy var viewModel = {
        MenuSliderViewModel()
    }()
    var arrayResponse = ["Book a Reservation","Ride Info","DHB-Ride Info","Available Cards","Settings","Logout"];//@"Future Ride Info",@"Future Ride History",
    var arr_images = [UIImage(named :"route"),UIImage(named :"home"),UIImage(named :"home"),UIImage(named :"payment"),UIImage(named :"tools"),UIImage(named :"exit")];//,[UIImage imageNamed:@"futurebooking"],[UIImage imageNamed:@"history"]

    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.loadUserData()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func deleteAccountBtnref(_ sender: Any) {
        self.callDeleteAccountAction()
    }
    
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        // Show the Navigation Bar
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    
    //MARK: - Class Actions
    
    func loadUserData(){
        //User Name
        if let Str_FirstName = UserDefaults.standard.string(forKey: "UserFirstName"),let Str_LastName = UserDefaults.standard.string(forKey: "UserLastName") {
            self.lbl_UserNameRef.text = Str_FirstName + " " +  Str_LastName
        }
        //Last Name
        if let Str_Email = UserDefaults.standard.string(forKey: "UserEmailID") {
            self.lbl_EmailRef.text = Str_Email
         }
        
        //User Image
        if let Str_UserImage = UserDefaults.standard.string(forKey: "userProfilepic") {
            self.imageview_ProfileRef.sd_setImage(with: URL(string: Str_UserImage), placeholderImage: UIImage(named: "UserPic"))
         }
        
        self.tableview_MenuSliderRef.reloadData()
    }

}

extension SideMenuViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSliderTableViewCell", for: indexPath) as? MenuSliderTableViewCell else {return UITableViewCell()}
        cell.lbl_MenuSliderRef.text = arrayResponse[indexPath.row]
        cell.imageview_MenuSliderRef.image = arr_images[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayResponse[indexPath.row] == "Logout" {
            self.callLogoutAction()
        } else if arrayResponse[indexPath.row] == "Book a Reservation" {
           // dismiss(animated: true, completion: nil)
            self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard",animated:false)
        } else if arrayResponse[indexPath.row] == "Settings" {
            self.movetonextvc(id: "SettingsViewController", storyBordid: "Profile",animated:false)
        } else if arrayResponse[indexPath.row] == "Available Cards" {
            self.movetonextvc(id: "AvilableCardsViewController", storyBordid: "Profile",animated:false)
        } else if arrayResponse[indexPath.row] == "Ride Info" {
            self.movetonextvc(id: "RideHistoryViewController", storyBordid: "Profile",animated:false)
        } else if arrayResponse[indexPath.row] == "DHB-Ride Info" {
            self.movetonextvc(id: "DBHRideHistoryViewController", storyBordid: "DriverByTheHour",animated:false)
        }
        
        
    }
    
}

extension SideMenuViewController {
    func callLogoutAction() {
        let alertController = UIAlertController(title: kApptitle, message: I18n.LogoutAlert, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: { action in
            self.logoutApiCalling()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func callDeleteAccountAction() {
        let alertController = UIAlertController(title: I18n.deleteAccountTitle, message: I18n.DeleteAccountAlert, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteAccountApiCalling()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //Logout Api Intigartion
    func logoutApiCalling(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestForLogoutServices(perams: ["userid":userID]) { success, model, error in
            if success {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    UserDefaults.standard.set("", forKey: "UserLoginID")
                    UserDefaults.standard.set("", forKey: "RideRequestProcessingCheck")
                    UserDefaults.standard.set("", forKey: "CurrentNotificationTitle")
                    UserDefaults.standard.set("", forKey: "SelectedCardDetails")
                    self.resetDefaults()
                    if let delegate = UIApplication.shared.delegate as? AppDelegate {
                        delegate.MoveToLogin()
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
    
    //Logout Api Intigartion
    func deleteAccountApiCalling(){
        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestForDeleteAccountServices(perams: ["userid":userID]) { success, model, error in
            if success {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
//                    UserDefaults.standard.set("", forKey: "UserLoginID")
//                    UserDefaults.standard.set("", forKey: "RideRequestProcessingCheck")
//                    UserDefaults.standard.set("", forKey: "CurrentNotificationTitle")
//                    UserDefaults.standard.set("", forKey: "SelectedCardDetails")
//                    self.resetDefaults()
//                    if let delegate = UIApplication.shared.delegate as? AppDelegate {
//                        delegate.MoveToLogin()
//                    }
                    self.moveToLogOutPage()
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
}
