//
//  MarvelListViewModel.swift
//  Marvel
//
//  Created by Mac on 22/11/2022.
//

import Foundation
import RxSwift
import RxCocoa


class MarvelListViewModel : NSObject {
    
    
    var result:Box<Result> = Box(nil)
    
    
    func fetchMarvelListData(){
        let apiService  = APIService()
        
        
        self.result.value = nil
        apiService.getMarvelList( url:"",parameters: [:], completion:  { (result, error) in
            guard let data = result else {
                
                return self.result.value = nil
            }
            print(data)
            
            self.result.value = data
        })
    }
    
}
