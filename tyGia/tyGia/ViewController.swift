//
//  ViewController.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController  , UIPickerViewDataSource , UIPickerViewDelegate{

      let mang : [String] = ["mot","hai","ba","bon","nam","sau"]
    var mang2 = [getTyGia]()
    var mang3 : [AnyObject]! = nil
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    let picker : UIPickerView = {
        let pick = UIPickerView()
        pick.backgroundColor = UIColor.brown
        pick.translatesAutoresizingMaskIntoConstraints = false
        return pick
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                let queue1 = DispatchQueue(label: "queue1")
        
        queue1.async {
            Alamofire.request("http://floatrates.com/daily/usd.json").responseJSON { (response) in
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject> {
                    //print(dict)
                    for (key,values) in dict {
                        // print(dict[key]!)
                        
                        
                        // self.mang3.append(dict[key]!)
                        // print(self.mang3)
                        //   mang2.append(getJson(nameCuntry:dict[key]!["name"] , rateCuntry: dict[key]!["rate"], date: dict[key]!["date"], codeCuntry: dict[key]!["code"])
                        let date = dict[key]!["date"] as! String
                        let name = dict[key]!["name"] as! String
                        let code = dict[key]!["code"] as! String
                        let rate = String(dict[key]!["rate"] as! Float)
                        self.mang2.append(getTyGia(nameCuntry: name, rateCuntry: rate, update: date, codeCuntry: code))
                        
                        
                        
                    }
                    print(self.mang2[0].rateCuntry)
                    self.picker.delegate = self
                    self.picker.dataSource = self
                    self.indicator.stopAnimating()
                    
                }
            }
        }
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
       
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(picker)
        picker.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        picker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        picker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        picker.isHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    @IBAction func actionCuntry1(_ sender: AnyObject) {
        picker.isHidden = false
       
    }
    
    @IBAction func actionCuntry2(_ sender: AnyObject) {
        picker.isHidden = false
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mang2.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mang2[row].nameCuntry
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.isHidden = true
    }

}

