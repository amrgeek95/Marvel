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
        
        
        var parameters = ["ts":apiParameters.ts.rawValue,"apikey":apiParameters.apiKey.rawValue,"hash":apiParameters.hashKey.rawValue]
        
        print(parameters)
        
        AF.request(sourcesURL,method: .get, parameters: parameters).responseJSON {
            (response) in
            
            print(response.value)
            
            if let results = response.value as? [String:Any]{
                DispatchQueue.main.async {
                    
                    guard let status = results["status"] as? String else {return completion(false,self.emptyListData, nil) }
                    
                    guard let data = results["data"] as? [String:AnyObject] else {return completion(false,self.emptyListData, nil) }
                    guard let result = data["results"] as? [[String: Any]] else {return completion(false,self.emptyListData, nil) }
                    
                    completion(true,self.populateListFrom(data: data), nil)

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


