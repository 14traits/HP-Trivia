//
//  Constants.swift
//  HP Trivia
//
//  Created by John Rogers on 1/9/25.
//

import Foundation
import SwiftUI

enum Constants {
    static let hpFont = "PartyLetPlain"
}

struct infoBackgroundImage: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button {
    func doneButton() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.brown)
            .foregroundColor(.white)
    }
}
