//
//  ChatViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 27/09/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableRef:UITableView!
    @IBOutlet weak var msgTextRef:UITextField!
    
    lazy var viewModel = {
        ChatViewModel()
    }()
    
    var str_userID = String()
    var str_DriverID = String()
    var str_dateTime = String()
    
    var chatListHistory: [UserChatDatar] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm a"
        str_dateTime = dateFormat.string(from: Date())
        
        self.str_userID = "701"
        //UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        self.tableRef.backgroundColor = .darkGray
        self.tableRef.backgroundView?.backgroundColor = .darkGray
        
        //API Intigration
        self.getChatHistoryList(msg: "")
        
    }

   
    @IBAction func sendBtnRef(_ sender: Any) {
        guard let messagestr = msgTextRef.text, messagestr != "" else {
            self.ShowAlert(message: "Please add your message!")
            return
        }
    }
    
}
extension ChatViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: self.chatListHistory.count, numberOfsections: 1, data_MSG_Str: "Start communication now.")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatListHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
        cell.backgroundColor = .darkGray
        
        if self.chatListHistory[indexPath.row].sender ?? "" == str_userID {
            cell.ResprofileImgRef.isHidden = true
            cell.ResbagRef.isHidden = true
            cell.ResdateRef.isHidden = true
            cell.ResmsgRef.isHidden = true
            
            //User Image
            if let Str_senderImage = self.chatListHistory[indexPath.row].profileImageSender as? String {
                cell.SenprofileImgRef.sd_setImage(with: URL(string: API_URl.API_BASEIMAGE_URL +  Str_senderImage), placeholderImage: UIImage(named: "UserPic"))
             }
            cell.SenmsgRef.text = self.chatListHistory[indexPath.row].mesage as? String ?? ""
            
            // Date Convertion
            if let datestr = self.chatListHistory[indexPath.row].date_time,datestr != "" as? String {
                cell.SendateRef.text = formattedDateFromString2(inputDatestr: "yyyy-MM-dd HH:mm:ss", dateString: datestr, withFormat: "MM-dd-yyyy hh:mm a")
            } else if let datestr2 = self.chatListHistory[indexPath.row].date,datestr2 != "" as? String {
                cell.SendateRef.text = formattedDateFromString2(inputDatestr: "yyyy-MM-dd hh:mm a", dateString: datestr2, withFormat: "MM-dd-yyyy hh:mm a")
            }
            
            cell.SenprofileImgRef.isHidden = false
            cell.senBagRef.isHidden = false
            cell.SendateRef.isHidden = false
            cell.SenmsgRef.isHidden = false
            cell.SenprofileImgRef.layer.borderColor = UIColor.blue.cgColor
            cell.SenprofileImgRef.layer.borderWidth = 1
            cell.SenprofileImgRef.layer.cornerRadius = cell.ResprofileImgRef.frame.size.width/2;
            cell.SenprofileImgRef.layer.masksToBounds = true

        } else {
            cell.SenprofileImgRef.isHidden = true
            cell.senBagRef.isHidden = true
            cell.SendateRef.isHidden = true
            cell.SenmsgRef.isHidden = true
            
            //User Image
            if let Str_senderImage = self.chatListHistory[indexPath.row].profileImageReciever as? String {
                cell.SenprofileImgRef.sd_setImage(with: URL(string: API_URl.API_BASEIMAGE_URL +  Str_senderImage), placeholderImage: UIImage(named: "UserPic"))
             }
            cell.SenmsgRef.text = self.chatListHistory[indexPath.row].mesage as? String ?? ""
            
            // Date Convertion
            if let datestr = self.chatListHistory[indexPath.row].date_time,datestr != "" as? String {
                cell.SendateRef.text = formattedDateFromString2(inputDatestr: "yyyy-MM-dd HH:mm:ss", dateString: datestr, withFormat: "MM-dd-yyyy hh:mm a")
            } else if let datestr2 = self.chatListHistory[indexPath.row].date,datestr2 != "" as? String {
                cell.SendateRef.text = formattedDateFromString2(inputDatestr: "yyyy-MM-dd hh:mm a", dateString: datestr2, withFormat: "MM-dd-yyyy hh:mm a")
            }
            
            cell.ResprofileImgRef.isHidden = false
            cell.ResbagRef.isHidden = false
            cell.ResdateRef.isHidden = false
            cell.ResmsgRef.isHidden = false
            cell.ResprofileImgRef.layer.borderColor = UIColor.blue.cgColor
            cell.ResprofileImgRef.layer.borderWidth = 1
            cell.ResprofileImgRef.layer.cornerRadius = cell.ResprofileImgRef.frame.size.width/2;
            cell.ResprofileImgRef.layer.masksToBounds = true

        }
        
        return cell
    }
    
    
    
}

extension ChatViewController {
    func getChatHistoryList(msg: String) {
        
        indicator.showActivityIndicator()
        let perams = [ "senderid":str_userID,
                       "recieverid":str_DriverID,
                       "msg":msg,
                       "keyvalue":"user",
                       "date_time":str_dateTime
        ]
        self.viewModel.requestForChatViewAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let strUserdat = UserData.data as? [UserChatDatar]{
                    self.chatListHistory = strUserdat
                    }
                    self.tableRef.reloadData()
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

