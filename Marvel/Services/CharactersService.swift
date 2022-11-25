//
//  ApiService.swift
//  Marvel
//
//  Created by Mac on 22/11/2022.
//

import Foundation
import Alamofire

protocol CharactersServiceProtocol {
    func getMarvelList(completion: @escaping (_ success: Bool, _ results: Result?, _ error: String?) -> ())
}

class CharactersService: CharactersServiceProtocol {
    let emptyListData = Result(marvel: [Marvel](), offset: 0, limit: 0, count: 0)

    func getMarvelList(completion: @escaping (Bool, Result?, String?) -> ()) {
        
        
        if !Connectivity.isConnectedToInternet {
            completion(false,self.emptyListData, "Please check your internet connection")
            return
         }

        
        let parameters = ["ts":apiParameters.ts.rawValue,"apikey":apiParameters.apiKey.rawValue,"hash":apiParameters.hashKey.rawValue]
        
        
        
        AF.request(sourcesURL,method: .get, parameters: parameters).responseJSON {
            (response) in
            
            
            if let results = response.value as? [String:Any]{
                DispatchQueue.main.async {
                    
                    if results["code"] is Int {
                        guard results["status"] is String else {return completion(false,self.emptyListData, "") }
                        
                        guard let data = results["data"] as? [String:AnyObject] else {return completion(false,self.emptyListData, nil) }
                        guard data["results"] is [[String: Any]] else {return completion(false,self.emptyListData, nil) }
                        
                        completion(true,self.populateListFrom(data: data), nil)
                    }else{
                        completion(false,self.emptyListData, results["code"] as? String ?? "")
                    }
                    
                }
            }else{
                completion(false,self.emptyListData, nil)

            }
        }
    }
    
    private func populateListFrom(data: [String: Any]) -> Result {
        var marvels = [Marvel]()
        
         let offset  = (data["offset"] as? Int ) ?? 0
        let limit  = (data["limit"] as? Int ) ?? 0
        let count  = (data["count"] as? Int ) ?? 0
        guard let results = data["results"] as? [[String: Any]] else {return emptyListData }
        for item in results {
            
            marvels.append(Marvel(data: item))
        }
        print(marvels)
        
        
        return Result(marvel: marvels, offset: offset, limit: limit, count: count)
    }
}


