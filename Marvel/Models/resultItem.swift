//
//  CharacterResult.swift
//  Marvel
//
//  Created by Mac on 24/11/2022.
//

import Foundation

struct resultItem : Codable {

    let offset,limit,count:Int
    let items:[Item]
    
    init(item:[Item] , offset:Int,limit:Int, count:Int){
        self.items = item
        self.offset = offset
        self.limit = limit
        self.count = count
    }
     

}

struct Item: Codable {
    let id: Int
    let title: String
    let thumbnail :String
    init(data:[String:Any]){
        self.id = data["id"] as? Int ?? 0
        self.title = data["title"] as? String ?? ""
        let thumb = data["thumbnail"] as? [String:Any] ?? [:]
        thumbnail = "\(thumb["path"] as? String ?? "").\(thumb["extension"] as? String ?? "" )"
    }
}
