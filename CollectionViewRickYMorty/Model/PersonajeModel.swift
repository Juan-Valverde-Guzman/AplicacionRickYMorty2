//
//  PersonajeModel.swift
//  CollectionViewRickYMorty
//
//  Created by dam2 on 14/12/23.
//

struct PersonajeModel: Decodable {
    
    var id: Int
    
    var name: String
    
    var status: String
    
    var species: String
    
    var type: String
    
    var gender: String
    
    var origin: PersonajeModelOrigin
    
    var location: PersonajeModelLocation
    
    var image: String
    
    var episode: [String]
    
    var url: String
    
    var created: String
    
}
