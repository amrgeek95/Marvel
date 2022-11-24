//
//  itemApi.swift
//  Marvel
//
//  Created by Mac on 24/11/2022.
//

import Foundation
import Alamofire

protocol itemServiceProtocol {
    func getItemWithCharacterId(characterId:Int,type:String,url:String,completion: @escaping (_ success: Bool, _ results: resultItem?, _ error: String?) -> ())
}

class itemService:itemServiceProtocol {
    let emptyData = resultItem(item: [Item](), offset: 0, limit: 0, count: 0)
    
    func getItemWithCharacterId(characterId: Int = 0,type:String = "" , url : String = "", completion: @escaping (Bool, resultItem?, String?)->()) {
        let apiUrl = "\(sourcesURL)/\(characterId)/\(url)"
        var parameters = ["ts":apiParameters.ts.rawValue,"apikey":apiParameters.apiKey.rawValue,"hash":apiParameters.hashKey.rawValue]
        
        AF.request(apiUrl , method: .get,parameters: parameters).responseJSON{
            (response) in
            
            print(response.value)
            
            if let results = response.value as? [String:Any]{
                DispatchQueue.main.async {
                    
                    guard let status = results["status"] as? String else {return completion(false,self.emptyData, nil) }
                    
                    guard let data = results["data"] as? [String:AnyObject] else {return completion(false,self.emptyData, nil) }
                    guard let result = data["results"] as? [[String: Any]] else {return completion(false,self.emptyData, nil) }
                    
                    completion(true,self.populateListFrom(data: data), nil)

                }
            }else{
                completion(false,self.emptyData, nil)

            }
        }
    }
    private func populateListFrom(data: [String: Any]) -> resultItem {
        var items = [Item]()
        
        let offset  = (data["offset"] as? Int ) ?? 0
        let limit  = (data["limit"] as? Int ) ?? 0
        let count  = (data["count"] as? Int ) ?? 0
        guard let results = data["results"] as? [[String: Any]] else {return emptyData }
        for item in results {
            
            items.append(Item(data: item))
        }
        print(items)
        
        
        return resultItem(item: items, offset: offset, limit: limit, count: count)
    }
}
