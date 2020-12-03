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
    @State private var region = MKCoordinateRegion(center: LocationManager.location,
                                                   span: MKCoordinateSpan(latitudeDelta: 0.4,
                                                                          longitudeDelta: 0.4))
    @State var rating: Double = Double.random(in: 0..<5)
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region,
                annotationItems: viewModel.photos?.photos.photo ?? [],
                annotationContent: { photo in
                    MapAnnotation(coordinate: .init(latitude: Double(photo.latitude)!,
                                                    longitude: Double(photo.longitude)!)) {
                        NavigationLink(
                            destination: PhotoDetailView(photo: photo, rating: $rating),
                            label: {
                                CustomMapAnnotation(photo: photo)
                            })
                    }
                })
                .onAppear{
                    viewModel.getPhotos(numPhotos: viewModel.numOfSelectedPhotos)
                }.navigationBarTitle("Events", displayMode: .large)
        }.statusBarStyle(.lightContent)
    }
}

struct PhotosMapView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
