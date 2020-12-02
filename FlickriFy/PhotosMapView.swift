//
//  PhotosMapView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/2/20.
//

import SwiftUI
import MapKit

struct PhotosMapView: View {
    @StateObject  var viewModel:  PhotosViewModel
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222,
                                                                                  longitude: -0.1275),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.5,
                                                                          longitudeDelta: 0.5))

    var body: some View {
        
        Map(coordinateRegion: $region)
            .ignoresSafeArea()

    }
}

struct PhotosMapView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
