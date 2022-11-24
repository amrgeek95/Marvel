//
//  charactersListViewModel.swift
//  Marvel
//
//  Created by Mac on 24/11/2022.
//

import Foundation

class charactersListViewModel :NSObject {
    var result:Box<Result> = Box(nil)

    func getCharacters() {
        let apiService  = CharactersService()

        apiService.getMarvelList { success, model, error in
                if success, let characters = model {
                   
                    self.result.value = characters
                } else {
                    return self.result.value = nil
                }
            }
        }
}
