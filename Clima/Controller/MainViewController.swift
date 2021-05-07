//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, DataManagerDelegate {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    @IBOutlet weak var expertiseLabel: UILabel!
    
    var baru = ""
    var dataHandler = DataHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataHandler.delegate = self
        textInput.delegate = self
    }

    @IBAction func searchAction(_ sender: UIButton) {
        textInput.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInput.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.text = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let user = textInput.text {
            dataHandler.fetchData(user:user);
        }
        textInput.text = ""
    }
    
    func didUpdateData(data: Dictionary<String,String>){
        DispatchQueue.main.async {
            self.nameLabel.text = data["Name"]
            self.teamLabel.text = data["Team"]
            self.shiftLabel.text = data["Shift"]
            self.expertiseLabel.text = data["Expertise"]
            let url = URL(string: data["Photo"]!)
            let data = try? Data(contentsOf: url!) 
            self.conditionImageView.image = UIImage(data: data!)
        }
    }
}

