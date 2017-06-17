//
//  WebViewController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/16/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit

fileprivate let screenWidth = UIScreen.main.bounds.width
fileprivate let screenHeight = UIScreen.main.bounds.height

class WebViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topMargin: CGFloat = 20
        let webViewBarHeight: CGFloat = screenWidth * 167/1333 //Maintain aspect ration of original web_view_bar image
        let webViewBarButton = UIButton(frame: CGRect(x: 0, y: topMargin, width: screenWidth, height: webViewBarHeight))
        webViewBarButton.setImage(#imageLiteral(resourceName: "webview_bar"), for: .normal)
        webViewBarButton.setImage(#imageLiteral(resourceName: "webview_bar"), for: .selected)
        webViewBarButton.setTitle("Back", for: .normal)
        webViewBarButton.addTarget(self,
                                   action: #selector(buttonClickAction),
                                   for: .touchUpInside)
        
        self.view.addSubview(webViewBarButton)
        
        let webView = UIWebView(frame: CGRect(x: 0, y: webViewBarHeight + topMargin, width: screenWidth, height: screenHeight - (webViewBarHeight + topMargin)))
        self.view.addSubview(webView)
        
        let webLink = URL(string: webURLGlobal)
        let webLinkRequest = URLRequest(url: webLink!)
        webView.loadRequest(webLinkRequest)
        
        //layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        //webViewBarButton.hei

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClickAction(_ sender: UIButton!)
    {
        print("Web view button clicked")
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
