//
//  Constant.swift
//  Marvel
//
//  Created by Mac on 22/11/2022.
//

import Foundation
import UIKit

let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let hashkey = "bf89473129551077350784e92160198e"
let ts = "1"
let apikey = "0a6339ed210e61974da3cf71a4ed574f"

let sourcesURL = "https://gateway.marvel.com/v1/public/characters"
enum apiParameters : String {
    case ts = "1"
    case apiKey = "0a6339ed210e61974da3cf71a4ed574f"
    case hashKey = "bf89473129551077350784e92160198e"
}
