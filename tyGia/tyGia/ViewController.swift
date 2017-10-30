//
//  ViewController.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UIPickerViewDataSource , UIPickerViewDelegate{

      let mang : [String] = ["mot","hai","ba","bon","nam","sau"]
    
    let picker : UIPickerView = {
        let pick = UIPickerView()
        pick.backgroundColor = UIColor.brown
        pick.translatesAutoresizingMaskIntoConstraints = false
        return pick
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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

    @IBAction func actionCuntry1(_ sender: AnyObject) {
        picker.isHidden = false
        picker.delegate = self
        picker.dataSource = self
    }
    
    @IBAction func actionCuntry2(_ sender: AnyObject) {
        picker.isHidden = false
        picker.delegate = self
        picker.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mang.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mang[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.isHidden = true
    }

}

