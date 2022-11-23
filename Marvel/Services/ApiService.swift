//
//  ApiService.swift
//  Marvel
//
//  Created by Mac on 22/11/2022.
//

import Foundation
import Alamofire


class APIService {
    var completionHandler: (() -> Void)?
    
    var nextUrl:Box<String> = Box("")
    let emptyData = Result(marvel: [Marvel](), offset: 0, limit: 0, count: 0)

    func getMarvelList(url:String,parameters : [String:Any], nextUrl:String = "" , completion: @escaping (Result? , _ error: Error?)->()) {
        
        
        let api_url = (nextUrl.isEmpty) ? "\(sourcesURL + url)":nextUrl
        print(api_url)
        
        AF.request(api_url,method: .get, parameters: parameters).responseJSON {
            (response) in
            
            
            print(response.value)
            
            if let results = response.value as? [String:Any]{
                DispatchQueue.main.async {
                    
                    guard let status = results["status"] as? String else {return completion(self.emptyData, nil) }
                    
                    guard let data = results["data"] as? [String:AnyObject] else {return completion(self.emptyData, nil) }
                    guard let result = data["results"] as? [[String: Any]] else {return completion(self.emptyData, nil) }
                    
                    completion(self.recipesListFrom(data: data), nil)

                }
            }else{
                completion(nil, nil)

            }
        }
    }
    private func recipesListFrom(data: [String: Any]) -> Result {
        var marvels = [Marvel]()
        
         let offset  = (data["offset"] as? Int ) ?? 0
        let limit  = (data["limit"] as? Int ) ?? 0
        let count  = (data["count"] as? Int ) ?? 0
        guard let results = data["results"] as? [[String: Any]] else {return emptyData }

        
        for item in results {
            
            marvels.append(Marvel(data: item))
        }
        print(marvels)
        
        
        return Result(marvel: marvels, offset: offset, limit: limit, count: count)
    }
    /*
     func apiToGetEmployeeData(completion : @escaping (Employees) -> ()){
     URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
     if let data = data {
     
     let jsonDecoder = JSONDecoder()
     
     let empData = try! jsonDecoder.decode(Employees.self, from: data)
     completion(empData)
     }
     }.resume()
     }
     */
}
