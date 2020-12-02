//
//  PhotoDetailView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/2/20.
//

import SwiftUI
import LoremSwiftum


struct PhotoDetailView: View {
    let photo: Photo
    @Binding var rating: Double 
    var body: some View {
        ZStack(alignment: .bottom){
            FlickrFyRemoteImage(urlString: "\(photo.url_z)")
                .scaledToFill()
                .clipped()
                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                           startPoint: .center, endPoint: .bottom)
            HStack{
                VStack{
                    Text(photo.title)
                    RatingView(rating: $rating, starsSize: .constant(30))
                }
                Spacer()
                    .frame(width: 120)
            }.padding(.horizontal)
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .padding(.bottom)
        }.navigationBarTitle(photo.title, displayMode: .inline)
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: .init(id: Lorem.word,
                                     title: Lorem.word, datetaken: Lorem.word,
                                     views: Lorem.word, tags: Lorem.word, latitude: Lorem.word,
                                     longitude: "", accuracy: "", url_z: URL(string: "https://live.staticflickr.com/65535/50359179343_5995fb2e5d_z.jpg")!), rating: .constant(2))
    }
}
