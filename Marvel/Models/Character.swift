//
//  Marvel.swift
//  Marvel
//
//  Created by Mac on 22/11/2022.
//

import Foundation

struct Result : Codable {

    let offset,limit,count:Int
    let marvels:[Marvel]
    
    
    init(marvel:[Marvel] , offset:Int,limit:Int, count:Int){
        self.marvels = marvel
        self.offset = offset
        self.limit = limit
        self.count = count
    }
     

}
struct Marvel : Codable {
    let id: Int
    let name, description: String
    let modified: String
    let thumbnail: String
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories

    enum CodingKeys: String, CodingKey {
        case id, name , description
        case modified, thumbnail, resourceURI, comics, series, stories
    }
    init (data: [String: Any]) {
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String ?? ""
        description = data["description"] as? String ?? ""
        modified = data["modified"] as? String ?? ""
        let thumb = data["thumbnail"] as? [String:Any] ?? [:]
        thumbnail = "\(thumb["path"] as? String ?? "").\(thumb["extension"] as? String ?? "" )"
        resourceURI = data["resourceURI"] as? String ?? ""
        self.comics =  Comics(data: data["comics"] as? [String:Any] ?? [:])
        self.series =  Comics(data: data["comics"] as? [String:Any] ?? [:])
        self.stories =  Stories(data: data["stories"] as? [String:Any] ?? [:])
        
    }
}

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    var items: [ComicsItem]
    let returned: Int
    init(data:[String: Any]){
        self.available = data["available"] as? Int ?? 0
        self.collectionURI = data["collectionURI"] as? String ?? ""
        self.returned = data["returned"] as? Int ?? 0
        let comicitems = data["items"] as? [[String:Any]] ?? [[:]]
        self.items = [ComicsItem]()
        for item in comicitems {
            self.items.append(ComicsItem(data: item))
        }
        
    }
}
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
    init(data:[String:Any]){
        self.resourceURI = data[""] as? String ?? ""
        self.name = data["name"] as? String ?? ""
    }
}
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    var items: [StoriesItem]
    let returned: Int
    init(data:[String: Any]){
        self.available = data["available"] as? Int ?? 0
        self.collectionURI = data["collectionURI"] as? String ?? ""
        self.returned = data["returned"] as? Int ?? 0
        let storyitems = data["items"] as? [[String:Any]] ?? [[:]]
        self.items = [StoriesItem]()
        for storyitem in storyitems {
            self.items.append(StoriesItem(data: storyitem))
        }
    }
}

struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    
    init(data:[String:Any]){
        self.resourceURI = data[""] as? String ?? ""
        self.name = data["name"] as? String ?? ""
    }
}



