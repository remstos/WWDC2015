//
//  WebViewController.swift
//  RemiSantos
//
//  Created by Remi Santos on 20/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var closeButton: UIButton!
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.shadowColor = UIColor.grayColor().CGColor
        closeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        closeButton.layer.shadowOpacity = 1
        if url != nil {
            if let nsurl = NSURL(string: url!) {
                webView.loadRequest(NSURLRequest(URL: nsurl))
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
