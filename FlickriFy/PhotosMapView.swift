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

    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: viewModel.photos?.photos.photo ?? [],
            annotationContent: { attraction in
                MapAnnotation(coordinate: .init(latitude: Double(attraction.latitude)!,
                                                longitude: Double(attraction.longitude)!)) {
                    CustomMapAnnotation(photo: attraction)
                        .onTapGesture {
//                            print(attraction.name)
                        }
                }
            })
            .ignoresSafeArea()
            .onAppear{
                viewModel.getPhotos(numPhotos: viewModel.numOfSelectedPhotos)
            }

    }
}

struct PhotosMapView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

struct CustomMapAnnotation: View {
    let photo: Photo
    var body: some View {
        VStack{
            FlickrFyRemoteImage(urlString: "\(photo.url_z)")
                .frame(width: 50, height: 40)
            Text(photo.longitude)
        }
    }
}
