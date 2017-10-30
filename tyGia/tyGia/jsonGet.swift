//
//  jsonGet.swift
//  tyGia
//
//  Created by linhth on 10/30/17.
//  Copyright © 2017 AdnetPlus. All rights reserved.
//

import Foundation
import UIKit

struct getTyGia {
    var nameCuntry : String
    var rateCuntry : String
    var update : String
    var codeCuntry : String
    
    init(nameCuntry : String,rateCuntry : String, update : String,codeCuntry : String  ) {
        self.nameCuntry = nameCuntry
        self.rateCuntry = rateCuntry
        self.update = update
        self.codeCuntry = codeCuntry
    }
}
