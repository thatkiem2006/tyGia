//
//  ViewController.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController  , UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate{

      let mang : [String] = ["mot","hai","ba","bon","nam","sau"]
    var mang2 = [getTyGia]()
    var mang3 : [AnyObject]! = nil
    
    var selectedCuntry1 : Bool = false
    var selectedCuntry2 : Bool = false
    var rate1: Float = 0
    var rate2: Float = 0
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var dayUpdate: UILabel!
    @IBOutlet weak var viewAds: UIView!
    @IBOutlet weak var flag1: UIImageView!
    @IBOutlet weak var lblCuntry1: UILabel!
    @IBOutlet weak var flag2: UIImageView!
    @IBOutlet weak var lblCuntry2: UILabel!
    @IBOutlet weak var getToday: UIView!
    @IBOutlet weak var number: UITextField!
    
    
    let picker : UIPickerView = {
        let pick = UIPickerView()
        pick.backgroundColor = UIColor.lightGray
        pick.translatesAutoresizingMaskIntoConstraints = false
        return pick
    }()
    
    let viewtextfild : UIView = {
        let vtf = UIView()
        vtf.backgroundColor = UIColor.yellow
        vtf.translatesAutoresizingMaskIntoConstraints = false
        return vtf
    }()

    
    let textfild : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.red
        tf.layer.borderWidth = 2
        tf.layer.backgroundColor = UIColor.gray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
                        
                        print("============\(code) ========= \(name) =============\(rate) \n")
                    }
                    
                    print(self.mang2[0].rateCuntry)
                    self.picker.delegate = self
                    self.picker.dataSource = self
                    self.indicator.stopAnimating()
                    self.dayUpdate.text = self.mang2[0].update
                    
                }
            }
        }
        
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
    }

    
    // keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        view.addSubview(picker)
        picker.topAnchor.constraint(equalTo: getToday.bottomAnchor, constant: 20).isActive = true
        picker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        picker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        picker.bottomAnchor.constraint(equalTo: viewAds.topAnchor, constant: -10).isActive = true
        picker.layer.cornerRadius = 5
        
        picker.isHidden = true
        
//        view.addSubview(viewtextfild)
//        viewtextfild.topAnchor.constraint(equalTo: getToday.bottomAnchor, constant: 0).isActive = true
//        viewtextfild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        viewtextfild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
//        viewtextfild.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        viewtextfild.isHidden = true
//        
//        viewtextfild.addSubview(textfild)
//        textfild.topAnchor.constraint(equalTo: viewtextfild.topAnchor, constant: 10).isActive = true
//        textfild.leftAnchor.constraint(equalTo: viewtextfild.leftAnchor, constant: 20).isActive = true
//        textfild.rightAnchor.constraint(equalTo: viewtextfild.rightAnchor, constant: -20).isActive = true
//        textfild.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //textfild.isHidden = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    @IBAction func actionCuntry1(_ sender: AnyObject) {
        selectedCuntry1 = !selectedCuntry1
        picker.isHidden = false
        viewtextfild.isHidden = false
       
    }
    
    @IBAction func actionCuntry2(_ sender: AnyObject) {
        selectedCuntry2 = !selectedCuntry2
        picker.isHidden = false
        viewtextfild.isHidden = false
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue1") {
            let vc = segue.destination as! CaculateViewController
            if number.text == "" {
                vc.stringRecv = "\(rate2/rate1)"

            } else if let number = Float(number.text!) {
                let value = (rate2/rate1)*number
                vc.stringRecv = "\(value)"
            } else{
                vc.stringRecv = "Please enter again!"
            }
            
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mang2.count
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let v = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?[0] as! TableViewCell
        v.lbl.text = mang2[row].nameCuntry
        if let img6 = dictionaryCuntry[mang2[row].codeCuntry] {
           v.img.image = UIImage(named: img6)
        } else {
            
        }
        
        return v
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if selectedCuntry1 {
            lblCuntry1.text = mang2[row].nameCuntry
            flag1.image = UIImage(named: dictionaryCuntry[mang2[row].codeCuntry]!)
            rate1 = Float(mang2[row].rateCuntry)!
            
            print("***********\(mang2[row].nameCuntry)*******\(rate1)")
            
            selectedCuntry1 = false
        }
        if selectedCuntry2 {
            lblCuntry2.text = mang2[row].nameCuntry
            flag2.image = UIImage(named: dictionaryCuntry[mang2[row].codeCuntry]!)
            
            rate2 = Float(mang2[row].rateCuntry)!
            print("***********\(mang2[row].nameCuntry)*******\(rate2)")
            selectedCuntry2 = false
        }
        picker.isHidden = true
        viewtextfild.isHidden = true
    }

}

