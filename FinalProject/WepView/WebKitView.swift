//
//  WebKitView.swift
//  FinalProject
//
//  Created by Ahmed Attia on 3/29/21.
//

import UIKit
import WebKit


class WebKitView: UIViewController {

    var urlValue:String?
    
    
    @IBOutlet weak var wepView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = urlValue else { return}
        
        guard let url = URL(string: urlString) else { return }
        
        wepView.load(URLRequest(url:url))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
