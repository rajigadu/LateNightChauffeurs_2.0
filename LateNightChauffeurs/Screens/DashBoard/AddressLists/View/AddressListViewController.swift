//
//  AddressListViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 19/09/22.
//

import UIKit

class AddressListViewController: UIViewController {
    
    @IBOutlet weak var tableview_SavedAddressListRef: UITableView!
    @IBOutlet weak var lbl_SavedAddressListRef: UILabel!
    @IBOutlet weak var btn_AddressRef: UIButton!
    
    var str_ComingFromStatus = ""
    
    var ary_SavedAddressList :[Any] = []
    var str_SelectedCardID = ""
    var str_LoginUserID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        str_LoginUserID =  UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        self.tableview_SavedAddressListRef.estimatedRowHeight = 1000
        self.tableview_SavedAddressListRef.rowHeight = UITableView.automaticDimension
        self.title = "Address List"
        self.lbl_SavedAddressListRef.isHidden = true;
        self.tableview_SavedAddressListRef.isHidden = true;
        if self.str_ComingFromStatus == "Home" {
           // [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftarrow"] style:UIBarButtonItemStylePlain target:self action:@selector(btn_BackActionRef)] animated:YES];
           // self.navigationItem.leftBarButtonItem.tintColor = .white
        } else {
           // [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(btn_BackActionRef)] animated:YES];
           // self.navigationItem.leftBarButtonItem.tintColor = .white

        }
        self.btn_AddressRef.layer.cornerRadius = 5.0
        self.btn_AddressRef.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.savedAddressListAPI()
    }
    

    @IBAction func btn_AddCardActionRef(_ sender: Any){
        self.movetonextvc(id: "AddressVC", storyBordid: "DashBoard", animated: true)
    }

}
extension AddressListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_SavedAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "AddressListTableViewCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! AddressListTableViewCell
//
//        NSString * str_Address1 =[[ary_SavedAddressList objectAtIndex:indexPath.row]valueForKey:@"street_address"] ;
//        NSString * str_Address2 =[[ary_SavedAddressList objectAtIndex:indexPath.row]valueForKey:@"address2"];

        
        
        return cell
    }
}

extension AddressListViewController {
    
    //MARK: - Get Saved Address list
    
    func savedAddressListAPI(){
        guard let str_userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}

//        if str_userID.isEmpty {
//            self.ShowAlert(message: "No User exists!")
//        } else {
//            indicator.showActivityIndicator()
//            self.viewModel.requestForChangePasswordServices(perams: ["userid":str_userID]) { success, model, error in
//                if success, let ForgotPasswordUserData = model {
//                    DispatchQueue.main.async { [self] in
//                        indicator.hideActivityIndicator()
//                        self.ShowAlertWithPop(message: ForgotPasswordUserData.userData?[0].Message ?? "Your Password has been updated successfully.")
//                    }
//                } else {
//                    DispatchQueue.main.async { [self] in
//                        indicator.hideActivityIndicator()
//                        self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
//                    }
//                }
//            }
//        }
    }
}
