//
//  NotesViewModel.swift
//  TodoAppSwiftUI
//
//  Created by Alberto Alegre Bravo on 16/2/22.
//

import Foundation
import SwiftUI

final class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    
    init(){
        notes = getAllNotes()
    }

    func saveNote(description: String){
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encondeAndSaveAllNotes()
    }
    
    private func encondeAndSaveAllNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        return []
    }
    
    func removeNote(withID id: String) {
        notes.removeAll(where: { $0.id == id })
        encondeAndSaveAllNotes()
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>){
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encondeAndSaveAllNotes()
    }
    
    func getNumberOfNotes() -> String {
        return "\(notes.count)"
    }
}
