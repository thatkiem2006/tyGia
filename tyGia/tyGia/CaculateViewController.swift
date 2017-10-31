//
//  CaculateViewController.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import UIKit

class CaculateViewController: UIViewController {

    var stringRecv : String = ""
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblCopyright: UILabel!
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

}
