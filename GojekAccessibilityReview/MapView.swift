//
//  MapView.swift
//  GojekAccessibilityReview
//
//  Created by Yuga Samuel on 04/12/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var selectedService = Service.example1
    
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
                ForEach(MapView.services) { service in
                    CardView(service)
                        .onTapGesture {
                            selectedService = service
                        }
                }
                
                OrderInteractionView(service: $selectedService)
            }
            .presentationDetents([.fraction(0.45), .fraction(0.75)])
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled()
            .presentationCornerRadius(24)
        }
    }
}

extension MapView {
    static let mapPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -6.2349,
                                           longitude: 106.9923),
            span: MKCoordinateSpan(latitudeDelta: 0.01,
                                   longitudeDelta: 0.01)
        )
    )
    
    static let services = [Service.example1, Service.example2]
    
    struct CardView: View {
        let service: Service
        
        init(_ service: Service) {
            self.service = service
        }
        
        var body: some View {
            HStack(spacing: 16) {
                Image(service.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                
                VStack {
                    HStack {
                        Text(service.name)
                            .fontWeight(.semibold)
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                            Text("Rp\(service.totalPrice)")
                                .fontWeight(.semibold)
                        }
                    }
                    
                    HStack {
                        HStack {
                            Text(service.duration)
                            HStack(spacing: 4) {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.secondary)
                                Text("\(service.maxPerson)")
                            }
                        }
                        Spacer()
                        Text("Rp\(service.price)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .strikethrough()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Is selected: \(service.name), price is \(service.totalPriceFormatted), estimated arrive \(service.duration)")
        }
    }
    
    struct OrderInteractionView: View {
        @Binding var service: Service
        
        var body: some View {
            VStack {
                HStack {
                    Image("Gopay")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                    Text("GoPay")
                        .fontWeight(.semibold)
                    Image(systemName: "chevron.right")
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.green)
                        Text("Rp \(service.discount) discount")
                    }
                    .fontWeight(.semibold)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .overlay {
                        Capsule()
                            .stroke(Color(UIColor.systemGray4))
                            .foregroundStyle(.clear)
                    }
                    
                    Image(systemName: "circle.grid.3x3.circle")
                        .font(.title)
                        .foregroundStyle(.green)
                }
                
                HStack {
                    Image(systemName: "calendar.circle")
                        .font(.title)
                        .foregroundStyle(.green)
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Order GoRide")
                                    .fontWeight(.semibold)
                                Text("You'll earn 20 XP")
                            }
                            
                            Spacer()
                            
                            Text("Rp\(service.totalPrice)")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.title2)
                        }
                    })
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.green)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 12)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Order")
        }
    }
    
    struct PickupAndDestinationView: View {
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundStyle(.green)
                    Text("Benny Motor, Bekasi Train Station")
                    Spacer()
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Pickup location: Benny Motor, Bekasi Train Station")
                .accessibilityAddTraits(.isButton)
                .accessibilityHint("Tap to change pickup location")
                
                Divider()
                
                HStack {
                    Image(systemName: "smallcircle.filled.circle.fill")
                        .foregroundStyle(.red)
                    Text("Home")
                    Spacer()
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Destination: Home")
                .accessibilityAddTraits(.isButton)
                .accessibilityHint("Tap to change destination")
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 1)
            .padding()
        }
    }
}

struct Service: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let duration: String
    let maxPerson: Int
    let price: Int
    let discount: Int
    
    var totalPrice: Int {
        return price - discount
    }
    
    var totalPriceFormatted: String {
        return NumberFormatter.localizedString(from: NSNumber(value: price - discount), number: .spellOut) + "Rupiah"
    }
    
    static let example1 = Service(name: "GoRide", image: "GoRide", duration: "3-7 mins", maxPerson: 1, price: 28500, discount: 3500)
    static let example2 = Service(name: "GoRide Comfort", image: "GoRide", duration: "3-7 mins", maxPerson: 1, price: 31000, discount: 3500)
}

#Preview {
    MapView()
}
