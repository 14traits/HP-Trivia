//
//  Instructions.swift
//  HP Trivia
//
//  Created by John Rogers on 1/11/25.
//

import SwiftUI

struct Instructions: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            infoBackgroundImage()
            
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                
                ScrollView {
                    Text("How To Play")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Welcome to HP Trivia! In this game, you will be asked random questions from the HP books and you must guess the right answer or you will lose points! 😱")
                            .padding([.horizontal, .bottom])
                        Text("Each quesiton is worth 5 points, but if you guess a wrong answer, you will lose 1 point.")
                            .padding([.horizontal, .bottom])
                        Text("if you are struggling with a question, there is an option to revieal a hint or the book that answers the question. But beware! Using these also minuses 1 point each.")
                            .padding([.horizontal, .bottom])
                        Text("WHen you select the correct answer you will be awarded the the points left for that quesiton and they will be added to your total score.")
                            .padding(.horizontal)
                    }
                    .font(.title3)
                    
                    Text("Good Luck!")
                        .font(.title)
                }
                .foregroundColor(.black)
                
                Button("Done") {
                    dismiss()
                }
                .doneButton()
            }
        }
    }
}

#Preview {
    Instructions()
}
