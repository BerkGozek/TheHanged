//
//  ContentView.swift
//  The Death Sentence
//
//  Created by Berk Gozek on 05/50/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var H    : Double = 1
    @State private var RA   : Double = 1
    @State private var B    : Double = 1
    @State private var LA   : Double = 1
    @State private var RL   : Double = 1
    @State private var HL   : Double = 1
    
    @State private var livesLeft: Int = 6
    
    @State private var alphabet = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I",
        "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]
    @State private var Selection = ""
    
    private var Answer: [String] =
        [
        "A", "d", "v", "a", "n", "c", "e", "d", " ",
        "P", "l", "a", "c", "e", "m", "e", "n", "t",
        ":", " ", "C", "o", "m", "p", "u", "t", "e",
        "r", " ", "S", "c", "i", "e", "n", "c", "e",
        " ", "P", "r", "i", "n", "c", "i", "p", "l",
        "e", "s"
        ]
    @State private var AnswerLC: [String] =
        [
        "a", "d", "v", "a", "n", "c", "e", "d", " ",
        "p", "l", "a", "c", "e", "m", "e", "n", "t",
        ":", " ", "c", "o", "m", "p", "u", "t", "e",
        "r", " ", "s", "c", "i", "e", "n", "c", "e",
        " ", "p", "r", "i", "n", "c", "i", "p", "l",
        "e", "s"
        ]
    @State private var OnScreen: [String] = [
        "_", "_", "_", "_", "_", "_", "_", "_", " ",
        "_", "_", "_", "_", "_", "_", "_", "_", "_",
        ":", " ", "_", "_", "_", "_", "_", "_", "_",
        "_", " ", "_", "_", "_", "_", "_", "_", "_",
        " ", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_"
    ]
    @State private var OnScreenSetotare = [
        "_", "_", "_", "_", "_", "_", "_", "_", " ",
        "_", "_", "_", "_", "_", "_", "_", "_", "_",
        ":", " ", "_", "_", "_", "_", "_", "_", "_",
        "_", " ", "_", "_", "_", "_", "_", "_", "_",
        " ", "_", "_", "_", "_", "_", "_", "_", "_",
        "_", "_"
    ].joined(separator: " ")
    
    
    
    
    var body: some View {
        
        VStack(spacing:0) {
            Image("Body")
                .resizable()
                .frame(width: 50,height: 250)
            Image("Head")
                .resizable()
                .frame(width: 50,height: 50)
                .opacity(H)
            HStack{
                Image("Left")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .opacity(LA)
                    .overlay(
                        Image("Body")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .opacity(B)
                            .overlay(
                                Image("Right")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .opacity(RA)
                            )
                    )
            }//Body Falan
            HStack(spacing : 0){
                Image("Left")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image("Right")
                            .resizable()
                            .frame(width: 50, height: 50)
                    )
                
            }//Bacak falan
            Spacer()
            Text(OnScreenSetotare)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Picker("Select Next Letter", selection: $Selection) {
                ForEach(Array(alphabet.enumerated()), id: \.element) { index, letter in
                    Text(letter)
                        }
            }.buttonStyle(.bordered)
                .padding(.bottom)
            Button("Submit Letter"){
                LetterSubmit(inp: Selection)
            }
            .buttonStyle(.bordered)
            
        }
        .padding()
        
        
    }
    
    func LetterSubmit(inp: String) {
        if Answer.contains(inp) {
            for index in AnswerLC.indices where AnswerLC[index] == inp.lowercased() {
                OnScreen[index] = Answer[index]
                AnswerLC[index] = "_"
            }
        } else {
            livesLeft -= 1
        }
        OnScreenSetotare = OnScreen.joined(separator: " ")
        alphabet.remove(at: alphabet.firstIndex(of: inp.uppercased()) ?? 0)
    }


    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
