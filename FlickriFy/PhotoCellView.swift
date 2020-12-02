//
//  PhotoCellView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import SwiftUI
import CoreLocation

struct PhotoCellView: View {
    let photo: Photo
    
    var body: some View {
        ZStack{
            FlickrFyRemoteImage(urlString: "\(photo.url_z)")
                .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                .cornerRadius(10)
                .scaledToFill()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6),
                                                               Color.clear,
                                                               Color.clear,
                                                               Color.black.opacity(0.8)]),
                                   startPoint: .top, endPoint: .bottom)
                        .cornerRadius(10)
                )
            VStack{
                HStack{
                    VStack(spacing: 0){
                        Text("views: \(photo.views)")
                        RatingView(rating: .constant(Double.random(in: 0..<5)),
                                   starsSize: .constant(20))
                            .frame(width: 100, height: 20)
                    }.padding(.horizontal, 12)
                    Spacer()
                    
                    Text(photo.datetaken)
                }.padding(.horizontal)
                .font(.caption)
                .foregroundColor(.white)
                Spacer()
                Text("\(getDistance(photo.latitude, photo.longitude), specifier: "%.0f") Km")
                Text(photo.title)
                    .font(.title2)
                    .foregroundColor(.white)
            }.padding(.vertical, 12)
        }.padding(.horizontal)
    }
    
    private func getDistance(_ lat: String, _ long: String) -> Double {
        let coordinate = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
        let currentLocation = CLLocation(latitude: Double(LocationManager.shared.currentLocation?.latitude ?? 0.0),
                                         longitude: Double(LocationManager.shared.currentLocation?.longitude ?? 0.0))
        let distanceInMeters = coordinate.distance(from: currentLocation) / 1000 // result is in meters
        return distanceInMeters
    }
}

struct PhotoCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
