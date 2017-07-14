//
//  WebService.swift
//  ListViewDemo
//
//  Created by mac on 14/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation

class WebSerivce{
    
    static let shared = WebSerivce()
    private init() {}
    
    func getCity(Completion: (Data) -> Void){
        guard let path = Bundle.main.path(forResource: "City&State", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        
        let data = try! Data(contentsOf: url)
        Completion(data)
    }
}
