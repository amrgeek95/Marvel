//
//  charactersListViewModel.swift
//  Marvel
//
//  Created by Mac on 24/11/2022.
//

import Foundation

class charactersListViewModel :NSObject {
    var result:Box<Result> = Box(nil)

    func getCharacters(completion: @escaping (Bool, String?) -> ()) {
        let apiService  = CharactersService()
        apiService.getMarvelList { success, model, error in
            
            
                if success, let characters = model {

                    self.result.value = characters
                    completion(true, error)

                } else {
                    
                    completion(false,error ?? "please try again" )

                    
                     self.result.value = nil
                }
            }
     //   return responseStatus

    }

}
