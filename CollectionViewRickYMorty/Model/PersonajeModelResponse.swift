//
//  PersonajeModelResponse.swift
//  CollectionViewRickYMorty
//
//  Created by dam2 on 18/12/23.
//

struct PersonajeModelResponse: Decodable {
    
    var info: PersonajeModelInfo
    
    var results: [PersonajeModel]
    
}
