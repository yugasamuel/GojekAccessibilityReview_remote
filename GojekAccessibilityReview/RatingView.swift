//
//  RatingView.swift
//  GojekAccessibilityReview
//
//  Created by Yuga Samuel on 04/12/23.
//

import SwiftUI

struct RatingView: View {
    @State private var rating = 3
    var label = ""
    var maximumRating = 5
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        VStack {
            VStack {
                Text("How was the driver?")
                Text("(1 is dissapointing, 5 is awesome)")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.bottom)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("How was the driver? (1 is dissapointing, 5 is awesome)")
            
            HStack {
                if label.isEmpty == false {
                    Text(label)
                }
                
                ForEach(1..<maximumRating + 1, id: \.self) { number in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(number > rating ? offColor : onColor)
                        .onTapGesture {
                            rating = number
                        }
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(label)
            .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    if rating < maximumRating { rating += 1 }
                case .decrement:
                    if rating > 1 { rating -= 1 }
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    RatingView()
}
