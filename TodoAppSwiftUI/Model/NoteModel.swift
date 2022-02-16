//
//  NoteModel.swift
//  TodoAppSwiftUI
//
//  Created by Alberto Alegre Bravo on 16/2/22.
//

import Foundation

struct NoteModel: Codable {
    var id: String
    var isFavorited: Bool
    var description: String
    
    init(id: String = UUID().uuidString, isFavorited: Bool = false, description: String){
        self.id = id
        self.isFavorited = isFavorited
        self.description = description
    }
    

    
}
