//
//  MaravelCharacter.swift
//  Marvel
//
//  Created by Mac on 23/11/2022.
//

import Foundation



class characterDetailViewModel :NSObject {
    var Stories:Box<resultItem> = Box(nil)
    var Comics:Box<resultItem> = Box(nil)
    var Series:Box<resultItem> = Box(nil)

    
    
    func getItemDetail(id:Int = 0,type:String = "",url:String = "" ) {
        let apiService  = itemService()

        apiService.getItemWithCharacterId(characterId: id, type: type, url: url) { success, model, error in
                if success, let data = model {
                    switch type {
                    case "stories":
                        self.Stories.value = data
                    case "comics":
                        self.Comics.value = data
                    case "series":
                        self.Series.value = data
                    default:
                        return self.Stories.value = nil

                    }
                } else {
                    return self.Stories.value = nil
                }
            }
        }
    
    
}
