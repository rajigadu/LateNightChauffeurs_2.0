//
//  NotificationViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var tableviewref: UITableView!

    lazy var viewModel = {
        NotificationViewModel()
    }()
    var notificationListHistory: [NotificationDatar] = []
    var str_userID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        str_userID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        
        self.getNotificationList()
    }
    
}
extension NotificationViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: self.notificationListHistory.count, numberOfsections: 1, data_MSG_Str: "No data available")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationListHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NotificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        //Date
        if let NotificationDate = self.notificationListHistory[indexPath.row].date {
            let AttributeStr = "Date/Time : " + NotificationDate
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            let nsRange = NSString(string: AttributeStr).range(of: "Date/Time :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255.0, alpha: 1.0)], range: nsRange)

            cell.datalblref.attributedText = attrStri
        }

        //Message
        if let NotificationMessage = self.notificationListHistory[indexPath.row].message {
            let AttributeStr = "Message : " + NotificationMessage
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            let nsRange = NSString(string: AttributeStr).range(of: "Message :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255.0, alpha: 1.0)], range: nsRange)

            cell.messagelblref.attributedText = attrStri
        }
        //title
        if let NotificationTitle = self.notificationListHistory[indexPath.row].title {
            let AttributeStr = "Titile : " + NotificationTitle
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            let nsRange = NSString(string: AttributeStr).range(of: "Titile :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255.0, alpha: 1.0)], range: nsRange)

            cell.tiltelbl_ref.attributedText = attrStri
        }
        
        return cell
    }
    
    
    
}

extension NotificationViewController {
    func getNotificationList() {
        indicator.showActivityIndicator()
        let perams = [ "user_ID":str_userID]
        self.viewModel.requestForNotificationAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let strUserdat = UserData.data as? [NotificationDatar]{
                    self.notificationListHistory = strUserdat
                    }
                    self.tableviewref.reloadData()
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

