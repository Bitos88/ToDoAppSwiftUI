//
//  ContentView.swift
//  TodoAppSwiftUI
//
//  Created by Alberto Alegre Bravo on 16/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var descriptionNotes: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        NavigationView {
            
            
            VStack {
                
                Text("Write task to do")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $descriptionNotes)
                    .foregroundColor(.gray)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.pink, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)
                Button("Add Task") {
                    if !descriptionNotes.isEmpty {
                        notesViewModel.saveNote(description: descriptionNotes)
                        descriptionNotes = ""
                    }
                }
                .buttonStyle(.bordered)
                .tint(.pink)
                
                Spacer()
                
                if notesViewModel.notes.count > 0 {
                    Text("Swipe to Set Favorite or Delete")
                        .padding()
                }
                
                
                ZStack {
                    
                    List {
                        
                        ForEach($notesViewModel.notes, id: \.id) {
                            $note in
                            HStack{
                                if note.isFavorited{
                                    Text("⭐")
                                }
                                Text(note.description)
                            }
                            .swipeActions(edge: .trailing){
                                Button {
                                    notesViewModel.updateFavoriteNote(note: $note)
                                } label: {
                                    Label("Favorite", systemImage: "star.fill")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .leading){
                                Button {
                                    notesViewModel.removeNote(withID: note.id)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                                .tint(.red)
                            }
                        }
                    }
                    
                }
                
            }
            .navigationTitle("TODO APP")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(notesViewModel.getNumberOfNotes())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
