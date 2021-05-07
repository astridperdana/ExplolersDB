//
//  DataHandler.swift
//  Clima
//
//  Created by Octgi Ristya Perdana on 06/05/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DataManagerDelegate {
    func didUpdateData(data: Dictionary<String,String>)
}

struct DataHandler {
    let src = "https://nc2.theideacompass.com/explorers-api.json"
    
    var delegate: DataManagerDelegate?
    
    func fetchData(user: String){
        let userSelected = user
        let usrData = performRequest(source: src, userChoosen: userSelected)
//        let usrChoosenData = ExplolerData(Name: usrData["Name"]!, Photo: usrData["Photo"]!, Expertise: usrData["Expertise"]!, Team: usrData["Team"]!, Shift: usrData["Shift"]!)
//        print(usrData["Name"])
        
    }
    
    func performRequest(source:String, userChoosen:String){
        if let url = URL(string: source){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data, let _ = String(data:safeData, encoding: .utf8) {
                    let arr = JSON(safeData)
                    var emptyDictionary = [String: String]()
                    var found = 0
                    for i in arr{
                        if i.1["Name"].stringValue == userChoosen{
                            emptyDictionary["Name"] = i.1["Name"].stringValue
                            emptyDictionary["Team"] = i.1["Team"].stringValue
                            emptyDictionary["Shift"] = i.1["Shift"].stringValue
                            emptyDictionary["Photo"] = i.1["Photo"].stringValue
                            emptyDictionary["Expertise"] = i.1["Expertise"].stringValue
                            found = 1
                        }
                    }
                    
                    if found == 0 {
                        emptyDictionary["Name"] = "Value Not Found"
                        emptyDictionary["Team"] = "Value Not Found"
                        emptyDictionary["Shift"] = "Value Not Found"
                        emptyDictionary["Photo"] = "https://developer.apple.com/design/human-interface-guidelines/sf-symbols/images/icloud-slash-fill_2x.png"
                        emptyDictionary["Expertise"] = "Value Not Found"
                    }
                    delegate?.didUpdateData(data: emptyDictionary)
//                    let dataVC = WeatherViewController()
//                    dataVC.didUpdateData(data: emptyDictionary)
//                    debugPrint(emptyDictionary)
//                    usrArr = emptyDictionary
                    
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
//                    self.parseJSON(exData: safeData)
                }
            }
            task.resume()
        }
    }
}
