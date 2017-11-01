//
//  CaculateViewController.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import UIKit
import CoreData

class CaculateViewController: UIViewController {

    var stringRecv : String = ""
    var mang3 = [getTyGia]()
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblCopyright: UILabel!
    
    
    
    
    //let appDelegate2 = UIApplication.shared.delegate as! AppDelegate
    
    //let context = appDelegate2.persistentContainer.viewContext
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblResult.text = stringRecv
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
   
    @IBAction func actionBtCopyright(_ sender: AnyObject) {
        lblCopyright.text = "@Copyright:\n giacatluong86ht@gmail.com"
    }
    

    @IBAction func actionSave(_ sender: AnyObject) {
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
        
    }
    
    @IBAction func actionGet(_ sender: AnyObject) {
      
        getCoredata = true

//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tygia")
//        request.returnsObjectsAsFaults = false
//        
//        do {
//            let results = try context.fetch(request)
//            if results.count > 0 {
//                for result in results as! [NSManagedObject]  {
//                    
//                    if let nameCuntry = result.value(forKey: "nameCuntry") as? String
//                    {
//                        print(nameCuntry)
//                    }
//                    if let rateCuntry = result.value(forKey: "rateCuntry") as? String
//                    {
//                        print(rateCuntry)
//                    }
//                    if let update = result.value(forKey: "update") as? String
//                    {
//                        print(update)
//                    }
//                    if let codeCuntry = result.value(forKey: "codeCuntry") as? String
//                    {
//                        print(codeCuntry)
//                    }
//                    
//                }
//            }
//            
//        } catch {
//            
//        }
//    }
    
    
    
    
    
    
    
    }
    
}
