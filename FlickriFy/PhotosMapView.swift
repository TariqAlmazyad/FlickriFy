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
            annotationContent: { photo in
                MapAnnotation(coordinate: .init(latitude: Double(photo.latitude)!,
                                                longitude: Double(photo.longitude)!)) {
                    CustomMapAnnotation(photo: photo)
                        
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
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .cornerRadius(25)
            Text(photo.title)
                .frame(width: widthForTitle(photo.title) + 10, height: 30)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2239803076, green: 0.2326877415, blue: 0.2327780426, alpha: 1)), Color(#colorLiteral(red: 0.316411972, green: 0.3246032596, blue: 0.3246707916, alpha: 1))]),
                                   startPoint: .leading, endPoint: .trailing)
                )
                .overlay(
                    Capsule()
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(.white)
                )
                .cornerRadius(15)
                .foregroundColor(.white)
        }
    }
    
    private func widthForTitle(_ title: String) -> CGFloat {
        let string = title
        return string.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .bold))
    }
}


extension String {
    
    /// Useful extension to get the width of any string for dynamic sizing and styling
    /// - Parameter font: you can pass the desired font to calculate the with based on the font type , e,g bold is little larger than light or regular
    /// - Returns: CGFloat as width for Any Text view
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
