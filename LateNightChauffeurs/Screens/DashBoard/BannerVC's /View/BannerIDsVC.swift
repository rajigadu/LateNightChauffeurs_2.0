//
//  BannerIDsVC.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 04/10/22.
//

import UIKit

class BannerIDsVC: UIViewController {
    @IBOutlet weak var imageview_BannerRef: UIImageView!
    @IBOutlet weak var btn_OpenWebUrlRef: UIButton!
    var str_TodayDate = ""
    var timerForBannerADs: Timer? = nil
    var curCheckingStateForBanners = 0
    var ary_BannerAdsList : [BannerDatar] = []
    var websiteURLForSelectedBannerAD = ""
    var str_AppVersion = ""
    lazy var viewModel = {
        BannerViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        str_AppVersion = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String ?? ""

        //Get todays date For Banner api......
        
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        str_TodayDate = dateFormatter.string(from: todayDate)
        //Banner api calling.................
        self.bannerADAPI(str_CurrentDate: str_TodayDate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        invalidateTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        invalidateTimer()
    }
    
    @IBAction func btn_CloseActionRef(_ sender: Any) {
        invalidateTimer()
        UserDefaults.standard.set("BannersClosedCheck", forKey: "BannersClosedNotification")
        
        NotificationCenter.default.post(
            name: NSNotification.Name("BannersDisabled"),
            object: self,
            userInfo: nil)
        dismiss(animated: false)
    }

}
extension BannerIDsVC {
    func bannerADAPI(str_CurrentDate: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}
        guard let FCMDeviceToken = UserDefaults.standard.string(forKey: "FCMDeviceToken") else{return}

        indicator.showActivityIndicator()
        
        self.viewModel.requestForbannerServices(perams: ["currentdate":str_CurrentDate,"userid":str_userID,"devicetoken":FCMDeviceToken,"device_type": "ios","app_version": str_AppVersion]) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    var timeDelay = UserData.delay ?? ""
                    if UserData.status == "1" {
                        if let response = UserData.data as? [BannerDatar] {
                            ary_BannerAdsList = response
                        }
                    }
                    let timeDelayValue = Int(timeDelay)
                    let seconds: Float = Float(Double(timeDelayValue ?? 0) / 1000.0)
                    let profileURL = ary_BannerAdsList[0].banner_logo ?? ""
                    let finalImageURL = API_URl.API_BANNERIMAGEBASE_URL + profileURL
                    var datastr : Data? = nil
                    if let url = URL(string: finalImageURL) {
                        do {
                        datastr = try Data(contentsOf: url)
                        } catch {
                            print("error")
                        }
                    }
                    var img: UIImage? = nil
                    if let iamgesp =  datastr as? Data {
                        img = UIImage(data: iamgesp)
                    }
                    self.imageview_BannerRef.image = img
                    timerForBannerADs = Timer.scheduledTimer(
                        timeInterval: TimeInterval(seconds),
                        target: self,
                        selector: #selector(handleTimerBannerADs),
                        userInfo: nil,
                        repeats: true)
                    self.btn_OpenWebUrlRef.isUserInteractionEnabled = true
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.imageview_BannerRef.contentMode = .scaleAspectFit
                    self.imageview_BannerRef.image = UIImage(named: "appLogo")
                }
            }
        }
        
    }
    
    func invalidateTimer() {
        if ((timerForBannerADs?.isValid) != nil) {
            timerForBannerADs?.invalidate()
            timerForBannerADs = nil
        }
    }
    
    @objc func handleTimerBannerADs(sender: UIButton) {
        if curCheckingStateForBanners < ary_BannerAdsList.count {
            var finalImageURL = ""
            guard let profileURL = ary_BannerAdsList[curCheckingStateForBanners].banner_logo as? String else {return }
            finalImageURL = API_URl.API_BANNERIMAGEBASE_URL + profileURL
            
            if let StrUrl = ary_BannerAdsList[curCheckingStateForBanners].url {
                websiteURLForSelectedBannerAD = StrUrl
            }
            if profileURL == "" {
                let img = UIImage(named: "appLogo")
                DispatchQueue.main.async
                {
                    self.imageview_BannerRef.contentMode = .scaleAspectFit
                    self.imageview_BannerRef.image = img
                    self.btn_OpenWebUrlRef.addTarget(self, action: #selector(self.loadingwebUrlBasedselectedBannerADClicked), for: .touchUpInside)
                }
            } else {
                if let url = URL(string: finalImageURL) {
                    do {
                        if let datastr = try Data(contentsOf: url) as? Data {
                            let img = UIImage(data: datastr)
                            DispatchQueue.main.async
                            {
                                self.imageview_BannerRef.contentMode = .scaleAspectFit
                                self.imageview_BannerRef.image = img
                                self.btn_OpenWebUrlRef.addTarget(self, action: #selector(self.loadingwebUrlBasedselectedBannerADClicked), for: .touchUpInside)
                            }
                        }
                    } catch  {
                        print("Some Error ")
                    }
                }
            }
            curCheckingStateForBanners += 1
        } else {
            curCheckingStateForBanners = 0
        }
    }
    
    @objc func loadingwebUrlBasedselectedBannerADClicked(sender: UIButton) {
        if websiteURLForSelectedBannerAD != "" {
            var mainURL: String = ""
            let t_st = "http"
           // let rang = websiteURLForSelectedBannerAD.range(of: t_st, options: .caseInsensitive)
            if self.websiteURLForSelectedBannerAD.contains(t_st) {
                //NSLog(@"done");
                mainURL = websiteURLForSelectedBannerAD
            } else {
                //NSLog(@"not done");
                mainURL = "http://\(websiteURLForSelectedBannerAD)"
            }
            
            if let url = URL(string: mainURL) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:]) { success in
                        print("Open URL")
                    }
                }
            }
        }
    }
}
