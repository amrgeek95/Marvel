//
//  Network.swift
//  Marvel
//
//  Created by Mac on 25/11/2022.
//

import Foundation
import Alamofire
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
