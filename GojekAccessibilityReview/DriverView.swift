//
//  DriverView.swift
//  GojekAccessibilityReview
//
//  Created by Yuga Samuel on 04/12/23.
//

import SwiftUI
import MapKit

struct DriverView: View {
    var body: some View {
        ZStack {
            Map(position: .constant(MapView.mapPosition))
            
            VStack {
                PickupAndDestinationView()
                Spacer()
            }
        }
        .sheet(isPresented: .constant(true)) {
            VStack {
                DriverProfileView(driver: Driver.example)
            }
            .presentationDetents([.fraction(0.25), .fraction(0.75)])
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled()
            .presentationCornerRadius(24)
        }
    }
}

extension DriverView {
    struct Driver {
        let licensePlate: String
        let name: String
        let rating: Int
        
        static let example = Driver(licensePlate: "E1822FCC", name: "Yuga Samuel", rating: 5)
    }
    
    static let mapPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -6.2349,
                                           longitude: 106.9923),
            span: MKCoordinateSpan(latitudeDelta: 0.01,
                                   longitudeDelta: 0.01)
        )
    )
    
    struct DriverProfileView: View {
        let driver: Driver
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(driver.licensePlate)
                        .font(.title)
                        .fontWeight(.semibold)
                    Divider()
                    HStack {
                        Text(driver.name)
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text("\(driver.rating)")
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .scaleEffect(1.5)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding()
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Driver's license plate is: \(driver.licensePlate), driver's name is \(driver.name), rating: \(driver.rating)")
        }
    }
}

#Preview {
    DriverView()
}
