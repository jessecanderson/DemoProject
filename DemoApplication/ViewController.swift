//
//  ViewController.swift
//  DemoApplication
//
//  Created by Jesse Anderson on 9/2/19.
//  Copyright © 2019 Jesse Anderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apiResponse: APIResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageSetup()
    }
    
    func pageSetup() {
        let url = "https://api.superfanu.com/8.0/networks/container/available/search?search=Blue"
        
        Networking.makeAPICall(url: url) { response in
            switch response {
            case .success(let networkResponse):
                self.apiResponse = networkResponse
                
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}

