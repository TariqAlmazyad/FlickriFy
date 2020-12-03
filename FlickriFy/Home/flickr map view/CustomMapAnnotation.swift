//
//  CustomMapAnnotation.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/3/20.
//

import SwiftUI


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
struct CustomMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
