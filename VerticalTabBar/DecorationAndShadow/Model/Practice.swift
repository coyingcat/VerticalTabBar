//
//  Practice.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/12/2.
//  Copyright © 2019 Jz D. All rights reserved.
//

import Foundation


struct Practice: Decodable {
    let collection: Int
    let is_audio: Int
    let material_or_level: String
    
    let musical: String
    let scores_name: String
    let id: Int
    
    let material: String
}



extension Practice{
    
    var desp: String{
        "\(material) ･ \(musical)\(material_or_level)"
    }
}



struct Info{
    static let data: [Practice] = {
        if let path = Bundle.main.url(forResource: "one", withExtension: "plist"), let data = try? Data(contentsOf: path){
            let plistDecoder = PropertyListDecoder()
            let result = try? plistDecoder.decode(General<Practice>.self, from: data)
            return result?.data ?? []
        }
        return []
    }()
}




struct General<T>: Decodable  where T: Decodable {
    let code: Int
    let data: [T]
}

