//
//  DBHChatViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 21/03/23.
//

import UIKit

class DBHChatViewController: UIViewController {
    
    @IBOutlet weak var tableRef:UITableView!
    @IBOutlet weak var msgTextRef:UITextField!
    
    lazy var viewModel = {
        DBHChatViewModel()
    }()
    
    var str_userID = String()
    var str_DriverID = String()
    var str_dateTime = String()
    var vcCmgFrom = ""
    var chatListHistory: [UserChatDatar] = []
    var spinner = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        spinner = UIActivityIndicatorView(style: .large)
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60)
        tableRef.tableFooterView = spinner
        
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm a"
        str_dateTime = dateFormat.string(from: Date())
        
        self.str_userID = UserDefaults.standard.string(forKey: "UserLoginID") ?? ""
        self.tableRef.backgroundColor = .darkGray
        self.tableRef.backgroundView?.backgroundColor = .darkGray
        
        //API Intigration
        self.getChatHistoryList(msg: "", str_rdateTime: str_dateTime)
        
        //self.navigationController?.navigationBar.topItem?.title = "Notifications"
        var imagestr = UIImage(named: "leftarrow")
        
        imagestr = imagestr?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        
        if vcCmgFrom == "AppDelegate" {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(backToMenu))
            
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backToDashboard))
            navigationController?.navigationBar.barTintColor = UIColor.black
        }
    }
    
    @objc func backToMenu() {
        self.navigateToSideMenu()
    }
    
    @objc func backToDashboard() {
        self.popToBackVC()
    }
    
    @IBAction func sendBtnRef(_ sender: Any) {
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        str_dateTime = dateFormatter.string(from: currDate)
        
        if msgTextRef.text?.count ?? 0 <= 0 {
            return
        } else {
            
            self.getChatHistoryList(msg: msgTextRef.text ?? "",str_rdateTime: str_dateTime)
            
        }
    }
    
}
extension DBHChatViewController : UITableViewDataSource,UITableViewDelegate{
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
            cell.ResmsgRef.text = self.chatListHistory[indexPath.row].mesage ?? ""
            
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

extension DBHChatViewController {
    func getChatHistoryList(msg: String,str_rdateTime: String) {
        
        indicator.showActivityIndicator()
        let perams = [ "senderid":str_userID,
                       "recieverid":str_DriverID,
                       "msg":msg,
                       "keyvalue":"user",
                       "date_time":str_rdateTime
        ]
        self.viewModel.requestForDBHChatViewAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let strUserdat = UserData.data as? [UserChatDatar]{
                        self.chatListHistory = strUserdat
                    }
                    
                    self.tableRef.reloadData()
                    self.scrollToBottom()
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatListHistory.count-1, section: 0)
            self.tableRef.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reloadDistance = CGFloat(30.0)
        if y > h + reloadDistance {
            print("fetch more data")
            //API Intigration
            self.getChatHistoryList(msg: "", str_rdateTime: str_dateTime)
            spinner.startAnimating()
        }
    }
    
    enum scrollsTo {
        case top,bottom
    }
}

