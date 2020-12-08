//
//  PhotosMapView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/2/20.
//

import SwiftUI
import MapKit


struct PhotosMapView: View {
    @State var rating: Double = Double.random(in: 0..<5)
    @StateObject  var viewModel:  PhotosViewModel
    // pass user location and the zoom level
    @State private var region = MKCoordinateRegion(center: LocationManager.location,
                                                   span: MKCoordinateSpan(latitudeDelta: 0.4,
                                                                          longitudeDelta: 0.4))
    
    var body: some View {
        // embed the view with NavigationView
        NavigationView {
            // create mapView
            Map(coordinateRegion: $region,
                annotationItems: viewModel.photos?.photos.photo ?? [], //<-- add the photos array to display it in the map.
                annotationContent: { photo in
                    MapAnnotation(coordinate: .init(latitude: Double(photo.latitude)!,
                                                    longitude: Double(photo.longitude)!)) {
                        NavigationLink(
                            destination: PhotoDetailView(photo: photo, rating: $rating),
                            label: {
                                CustomAnnotationView(photo: photo) // <-- create custom annotationView 
                            })
                    }
                })
                // once the view is loaded , fetch the photos
                .onAppear{
                    viewModel.getPhotos(numPhotos: viewModel.numOfSelectedPhotos)
                }.navigationBarTitle("Events", displayMode: .large)
        }.statusBarStyle(.lightContent)
    }
}

struct PhotosMapView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarHomeView()
            .preferredColorScheme(.dark)
    }
}
