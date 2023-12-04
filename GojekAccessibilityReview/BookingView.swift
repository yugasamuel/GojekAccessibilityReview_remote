//
//  BookingView.swift
//  GojekAccessibilityReview
//
//  Created by Yuga Samuel on 04/12/23.
//

import SwiftUI

struct BookingView: View {
    var body: some View {
        HStack {
            Image(systemName: "staroflife.shield.fill")
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text("Book GoRide & KRL ticket in one order")
                    .fontWeight(.bold)
                Text("Use promo code GOSTASIUN for 90% discount.")
            }
            
            Image(systemName: "chevron.right")
        }
        .modifier(CustomCardStyle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Book GoRide & KRL ticket in one order")
        .accessibilityAddTraits(.isButton)
        .accessibilityHint("Tap to enter a promo code in a new screen")
    }
}

extension BookingView {
    struct CustomCardStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundStyle(.white)
                .padding()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
        }
    }
}

#Preview {
    BookingView()
}
