//
//  ViewController.swift
//  DemoApplication
//
//  Created by Jesse Anderson on 9/2/19.
//  Copyright © 2019 Jesse Anderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var dismissKeyboardGesture = UITapGestureRecognizer()
    var apiResponse: APIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // pageSetup()
    }
    
//    func pageSetup() {
//        let url = "https://api.superfanu.com/8.0/networks/container/available/search?search=Blue"
//
//        Networking.makeAPICall(url: url) { response in
//            switch response {
//            case .success(let networkResponse):
//                self.apiResponse = networkResponse
//                self.tableView.reloadData()
//            case .failure(let error):
//                print("\(error)")
//            }
//        }
//    }
    
    @IBAction func searchAction(_ sender: Any) {
        self.view.endEditing(true)
        guard let searchValue = searchTextField.text, !searchValue.isEmpty else { return }
        
        let url = "https://api.superfanu.com/8.0/networks/container/available/search?search=\(searchValue)"
        
        Networking.makeAPICall(url: url) { response in
            switch response {
            case .success(let networkResponse):
                self.apiResponse = networkResponse
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if let textCheck = textField.text, !textCheck.isEmpty {
            self.searchAction(self)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.removeGestureRecognizer(dismissKeyboardGesture)
        textField.resignFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = apiResponse?.data.count else { return 0 }
        return sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rowCount = apiResponse?.data[section].count else { return 0 }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resueIdent", for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        let school = apiResponse?.data[indexPath.section][indexPath.row]
        
        cell.schoolNameLabel.text = school?.name
        cell.schoolAddressLabel.text = school?.address

        URLSession.shared.dataTask(with: URL(string: school!.img)!) { data, response, error in
            if error != nil {
                print("\(error)")
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                cell.schoolLogo.image = UIImage(data: data)
            }
        }.resume()
        
        return cell
    }
    
    
}

