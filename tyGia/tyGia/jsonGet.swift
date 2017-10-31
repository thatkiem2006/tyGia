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

var dictionaryCuntry : [String : String] = [
"DKK": "Danish",
"TRY" : "Turkish",
"SGD" : "Singapore",
"HUF" : "Hungarian",
"ISK" : "Icelandic",
"ILS" : "Israeli",
"RON" : "Romanian",
"VEF" : "Venezuelan",
"UAH" : "Ukrainian",
"TND" : "Tunisian",
"CLP" : "Chilean",
"KZT" : "Kazakhstani",
"LYD" : "Libyan",
"PKR" : "Pakistani",
"AZN" : "Azerbaijan",
"THB" : "Thai",
"CNY" : "Chinese",
"LBP" : "Lebanese",
"EUR" : "Euro",
"MXN" : "Mexican",
"ARS" : "Argentine",
"EGP" : "Egyptian",
"XOF" : "West African CFA",
"AED" : "U.A.E",
"KGS" : "Kyrgyzstan",
"NPR" : "Nepalese",
"BHD" : "Bahrain",
"MUR" : "Mauritian",
"NIO" : "Nicaraguan",
"AUD" : "Australian",
"JPY" : "Japanese",
"AMD" : "Armenia",
"BWP" : "Botswana",
"NOK" : "Norwegian",
"BGN" : "Bulgarian",
"PYG" : "Paraguayan",
"RUB" : "Russian",
"PEN" : "Peruvian",
"BYN" : "Belarussian",
"IDR" : "Indonesian",
"NZD" : "New Zealand",
"BBD" : "Barbadian",
"JOD" : "Jordanian",
"PHP" : "Philippine",
"NGN" : "Nigerian",
"UYU" : "Uruguayan",
"XAF" : "Central African CFA",
"TMT" : "New Turkmenistan",
"COP" : "Colombian",
"SAR" : "Saudi",
"MDL" : "Moldova",
"ZAR" : "South African",
"BRL" : "Brazilian",
"TWD" : "New Taiwan",
"QAR" : "Qatari",
"PGK" : "Papua New Guinean",
"UZS" : "Uzbekistan",
"KWD" : "Kuwaiti",
"BOB" : "Bolivian",
"CAD" : "Canadian",
"CHF" : "Swiss",
"MYR" : "Malaysian",
"GBP" : "U.K. Pound",
"CRC" : "Costa Rican",
"DZD" : "Algerian",
"HRK" : "Croatian",
"OMR" : "Omani",
"DOP" : "Dominican",
"KRW" : "South Korean",
"TTD" : "Trinidad Tobago",
"BND" : "Brunei",
"HKD" : "Hong Kong",
"LKR" : "Sri Lanka",
"TJS" : "Tajikistan",
"CZK" : "Czech",
"RSD" : "Serbian",
"INR" : "Indian",
"SEK" : "Swedish",
"VND" : "Vietnamese",
"PLN" : "Polish"]
