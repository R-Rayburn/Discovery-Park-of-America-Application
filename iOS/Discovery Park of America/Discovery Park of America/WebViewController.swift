//
//  WebViewController.swift
//  Discovery Park of America
//
//  Created by Paul Gosser on 9/5/17.
//  Copyright © 2017 Paul Gosser. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    
    override func loadView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://webstore1.centaman.net/discoveryparkofamerica/Logout/LoginViewProfile/tabid/61/Default.aspx")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        print("WebViewController loaded its view.")
    }
}
