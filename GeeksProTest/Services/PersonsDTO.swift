//
//  PersonsDTO.swift
//  GeeksProTest
//
//  Created by Apple on 25.5.2024.
//

import Foundation


struct PersonsDTO: Codable {
    let info: Info
       let results: [PersonDTO]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct PersonDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
