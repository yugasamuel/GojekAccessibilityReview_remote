//
//  ContentView.swift
//  GojekAccessibilityReview
//
//  Created by Yuga Samuel on 02/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Button(action: {
                // opens GoRide
            }, label: {
                VStack {
                    Image("GoRide")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                    Text("GoRide")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            })
            
            Image("-30k")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .offset(y: -70)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("GoRide, up to 30k discount")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    ContentView()
}
