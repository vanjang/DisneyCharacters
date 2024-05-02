//
//  ErrorView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import SwiftUI


struct ErrorView: View {
    let message: String
    
    var body: some View {
        Text("Error: \(message)")
            .foregroundColor(.red)
            .padding()
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "error message comes here")
    }
}
