//
//  PersonajeModelInfo.swift
//  CollectionViewRickYMorty
//
//  Created by dam2 on 18/12/23.
//

import Foundation

struct PersonajeModelInfo: Decodable {
    
    var count: Int
    
    var pages: Int
    
    var next: String
    
    var prev: Int?
    
}
