//
//  ContentView.swift
//  The Death Sentence
//
//  Created by Berk Gozek on 05/50/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing:0) {
            Image("Head")
                .resizable()
                .frame(width: 50,height: 50)
            HStack{
                Image("Left")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image("Body")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image("Right")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            )
                    )
            }//Body Fala
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
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
