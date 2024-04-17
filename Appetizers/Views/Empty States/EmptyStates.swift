//
//  EmptyStates.swift
//  Appetizers
//
//  Created by Phoon Thet Pine on 17/4/24.
//

import SwiftUI

struct EmptyStates: View {
    
    let imageName: String
    let message: String
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y: -50)
        }
    }
}

#Preview {
    EmptyStates(imageName: "empty-order", message: "This is our test mesage.\nI'm making it a little long for testing.")
}
