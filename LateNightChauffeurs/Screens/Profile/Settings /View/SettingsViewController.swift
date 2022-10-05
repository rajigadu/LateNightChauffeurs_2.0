//
//  SettingsViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var tableview_SettingsRef:UITableView!
    @IBOutlet weak var lbl_AppVersionRef:UILabel!
    
    //MARK: - Class Propeties
    let arrayResponse = ["Edit Profile Info","Change Password","Contact Us","Privacy Policy","Terms & Conditions"]
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        // self.str_AppVersion = UserDefaults.standard.string(forKey: "CFBundleShortVersionString") ?? ""
        let version = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String ?? ""

        lbl_AppVersionRef.text = "Version : \(version ?? "")"
        self.swipeRight()
        navigationController?.isNavigationBarHidden = false //Show
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Class Actions
    @IBAction func openSideMenu(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell else {return UITableViewCell()}
        cell.lbl_TitleRef.text = arrayResponse[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayResponse[indexPath.row] == "Terms & Conditions" {
            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "TermsAndPrivacyViewController") as! TermsAndPrivacyViewController
            nxtVC.str_ActionComingFrom = "Terms & Conditions"
            self.navigationController?.pushViewController(nxtVC, animated:  true)
        } else if arrayResponse[indexPath.row] == "Privacy Policy" {
            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "TermsAndPrivacyViewController") as! TermsAndPrivacyViewController
            nxtVC.str_ActionComingFrom = "Privacy Policy"
            self.navigationController?.pushViewController(nxtVC, animated:  true)
        } else if arrayResponse[indexPath.row] == "Contact Us" {
            self.movetonextvc(id: "ContactUsViewController", storyBordid: "Profile", animated: true)
        } else if arrayResponse[indexPath.row] == "Change Password" {
            self.movetonextvc(id: "ChangePasswordViewController", storyBordid: "Profile", animated: true)
        }else if arrayResponse[indexPath.row] == "Edit Profile Info" {
            self.movetonextvc(id: "ProfileViewController", storyBordid: "Profile", animated: true)
        }
    }

}
