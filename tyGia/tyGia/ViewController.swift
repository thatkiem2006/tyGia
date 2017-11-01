//
//  ViewController.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController  , UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

      let mang : [String] = ["mot","hai","ba","bon","nam","sau"]
    var mangOffLine = [getTyGia]()
    var mang3 : [AnyObject]! = nil
    
    var selectedCuntry1 : Bool = false
    var selectedCuntry2 : Bool = false
    var rate1: Float = 0
    var rate2: Float = 0
    var today: String!
    var  viewMore : UIView!
    var dem: Int = 1
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var dayUpdate: UILabel!
    @IBOutlet weak var viewAds: UIView!
    @IBOutlet weak var flag1: UIImageView!
    @IBOutlet weak var lblCuntry1: UILabel!
    @IBOutlet weak var flag2: UIImageView!
    @IBOutlet weak var lblCuntry2: UILabel!
    @IBOutlet weak var getToday: UIView!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var viewCuntry1: UIView!
    
    
    
    
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
        
        parseJson()
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
        
        //========navigationBar
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.red,
            NSFontAttributeName : UIFont(name: "Noteworthy", size: 20)!
        ]
        
        //======= picker
        view.addSubview(picker)
        picker.topAnchor.constraint(equalTo: getToday.bottomAnchor, constant: 20).isActive = true
        picker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        picker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        picker.bottomAnchor.constraint(equalTo: viewAds.topAnchor, constant: -10).isActive = true
        picker.layer.cornerRadius = 5
        
        picker.isHidden = true
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if dem == 1 {
            getCoredataFunc()
            dem = 2
        } else  {
            
        }
        
        
        print("**********=")
        print("\(mangOffLine.count)")
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
        //===================
        viewMore = Bundle.main.loadNibNamed("viewMore", owner: self, options: nil)?.first as! UIView
        view.addSubview(viewMore)
        viewMore.center.x =  getToday.center.x
        viewMore.frame.origin.y = getToday.frame.origin.y + getToday.frame.size.height
        let btOffline = viewMore.viewWithTag(2) as! UIButton
        btOffline.addTarget(self, action: #selector(actionBtOffline), for: .touchUpInside)
        let btSave = viewMore.viewWithTag(1) as! UIButton
        btSave.addTarget(self, action: #selector(actionBtSave), for: .touchUpInside)
        let btRefresh = viewMore.viewWithTag(3) as! UIButton
        btRefresh.addTarget(self, action: #selector(actionRefresh), for: .touchUpInside)
        viewMore.isHidden = true
        
    }
    
    @IBAction func actionMore(_ sender: AnyObject) {
        viewMore.isHidden = !viewMore.isHidden
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
                vc.stringRecv = "Plase enter again!"
            }
            
        }
    }
    
    //===========================
    
    func actionBtOffline(){
        getCoredata = !getCoredata
        let lbOfline = viewMore.viewWithTag(22) as! UILabel
        let btOnOff = viewMore.viewWithTag(2) as! UIButton
        if getCoredata {
            lbOfline.text = "Online"
            
            btOnOff.setImage(UIImage(named: "online"), for: .normal)
        } else {
            lbOfline.text = "Offline"
            btOnOff.setImage(UIImage(named: "offline"), for: .normal)
        }
        
        viewMore.isHidden = true
        picker.delegate = self
        picker.dataSource = self
        self.dayUpdate.text = mangOffLine[0].update
        
    }
    
    //==============================
    
    func actionRefresh(){
        mang2.removeAll()
        parseJson()
        guard mang2.count > 5 else {
            return
        }
        self.dayUpdate.text = mang2[0].update
    }
    
    
    //==============================
    
    func actionBtSave(){
        guard mang2.count > 5 else {
            return
        }
        
        

            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tygia")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        
        
        
        for i in 0 ..< mang2.count {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Tygia", into: context)
            newUser.setValue(mang2[i].nameCuntry, forKey: "nameCuntry") //pasword
            newUser.setValue(mang2[i].rateCuntry, forKey: "rateCuntry")
            newUser.setValue(mang2[i].update, forKey: "update") //pasword
            newUser.setValue(mang2[i].codeCuntry, forKey: "codeCuntry")
            do {
                try context.save()
                print("saved")
                print(newUser)
                
            } catch {
            }
        }
        

        
        getCoredataFunc()

        
        
    }
    
    
    
    //============================= parseJSON
    
    func parseJson(){
    
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
    mang2.append(getTyGia(nameCuntry: name, rateCuntry: rate, update: date, codeCuntry: code))
    
    print("============\(code) ========= \(name) =============\(rate) \n")
    }
    
    print("=======**")
    print(mang2)
    
    self.indicator.stopAnimating()
    self.dayUpdate.text = mang2[0].update
    mang2.append(getTyGia(nameCuntry: "America Dollar", rateCuntry: "1", update: "", codeCuntry: "USA"))
    
    //self.mang2.sorted(by: { $0.nameCuntry > $1.nameCuntry })
    mang2.sort { $0.nameCuntry < $1.nameCuntry }
    self.picker.delegate = self
    self.picker.dataSource = self
    
    }
    }
    }

    
    }
    
    
    
    
    
    
    
    
    
    
    
    //===========================
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if getCoredata {
            return mangOffLine.count
        } else {
            return mang2.count

        }
      }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let v = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?[0] as! TableViewCell
        
        if getCoredata {
                            v.lbl.text = mangOffLine[row].nameCuntry
                            if let img6 = dictionaryCuntry[mangOffLine[row].codeCuntry] {
                                v.img.image = UIImage(named: img6)
                            } else {
                                
                            }
                        return v
                } else {
                    v.lbl.text = mang2[row].nameCuntry
                    if let img6 = dictionaryCuntry[mang2[row].codeCuntry] {
                            v.img.image = UIImage(named: img6)
                    } else {
                
                            }
            return v
        }
       
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if selectedCuntry1 {
            
            if getCoredata == true {
                lblCuntry1.text = mangOffLine[row].nameCuntry
                //flag1.image = UIImage(named: mangOffLine[row].codeCuntry)
                
                if let img6 = dictionaryCuntry[mangOffLine[row].codeCuntry] {
                    flag1.image = UIImage(named: img6)
                } else {
                    
                }
                
                rate1 = Float(mangOffLine[row].rateCuntry)!
            } else {
                guard   mang2.count > 5  else {
                   return
                }
                lblCuntry1.text = mang2[row].nameCuntry
                if let img6 = dictionaryCuntry[mang2[row].codeCuntry] {
                    flag1.image = UIImage(named: img6)
                } else {
                        }
                rate1 = Float(mang2[row].rateCuntry)!
            }
            
            selectedCuntry1 = false
        }
        if selectedCuntry2 {
            if getCoredata {
                lblCuntry2.text = mangOffLine[row].nameCuntry
                //flag2.image = UIImage(named: mangOffLine[row].codeCuntry)
                
                if let img6 = dictionaryCuntry[mangOffLine[row].codeCuntry] {
                    flag2.image = UIImage(named: img6)
                } else {
                    
                }
                rate2 = Float(mangOffLine[row].rateCuntry)!
            } else {
                guard   mang2.count > 5  else {
                    return
                }
                lblCuntry2.text = mang2[row].nameCuntry
                if let img5 = dictionaryCuntry[mang2[row].codeCuntry] {
                    flag2.image = UIImage(named: img5)
                } else {
                        }
                rate2 = Float(mang2[row].rateCuntry)!
            }
            

            selectedCuntry2 = false
        }
        picker.isHidden = true
        viewtextfild.isHidden = true
    }
    
    
    
    
    
    
    func getCoredataFunc(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tygia")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                
                mangOffLine.removeAll()
                
                
                for result in results as! [NSManagedObject]  {
                    guard let nameCuntry = result.value(forKey: "nameCuntry") else {
                        return
                    }
                    guard let rateCuntry = result.value(forKey: "rateCuntry") else {
                        return
                    }
                    guard let update = result.value(forKey: "update") else {
                        return
                    }
                    guard let codeCuntry = result.value(forKey: "codeCuntry") else {
                        return
                    }
                    
                    
                    
                    mangOffLine.append(getTyGia(nameCuntry: nameCuntry as! String, rateCuntry: rateCuntry as! String, update: update as! String, codeCuntry: codeCuntry as! String))
                    
                }
                
                print("*********************")
                print(mangOffLine[1].nameCuntry)
                
                          }
            
        } catch {
            
        }
        
        
    }
    
    
    
    
    

}

