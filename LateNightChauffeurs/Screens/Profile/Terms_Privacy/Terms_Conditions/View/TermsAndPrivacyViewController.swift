//
//  TermsAndPrivacyViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 11/09/22.
//

import UIKit
import WebKit

class TermsAndPrivacyViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var webview_Ref:WKWebView!
    
    //MARK: - Class Propeties
    var str_ActionComingFrom: String?
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = str_ActionComingFrom
        var websiteUrl: URL?
        webview_Ref.isOpaque = false
        webview_Ref.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        if str_ActionComingFrom == "Terms & Conditions" {
            websiteUrl = URL(string: "\(API_URl.API_TERMSCONDITIONS_URL)")
        } else if str_ActionComingFrom == "Privacy Policy" {
            websiteUrl = URL(string: "\(API_URl.API_PRIVACYPOLICY_URL)")
        } else if str_ActionComingFrom == "Help" {
            websiteUrl = URL(string: "\(API_URl.API_HELP_URL)")
        }
        DispatchQueue.global(qos: .default).sync(execute: { [self] in
            if let webUrl = websiteUrl {
            let urlRequest = URLRequest(url: webUrl)
                webview_Ref.navigationDelegate = self
                webview_Ref.load(urlRequest)
            }
        })
        // Do any additional setup after loading the view.
    }
    //MARK: - Class Actions
}
extension TermsAndPrivacyViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        indicator.showActivityIndicator()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        indicator.hideActivityIndicator()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        indicator.hideActivityIndicator()
    }
}
