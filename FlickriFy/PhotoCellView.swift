//
//  PhotoCellView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import SwiftUI

struct PhotoCellView: View {
    let photo: Photo
    var body: some View {
        ZStack{
            FlickrFyRemoteImage(urlString: "\(photo.url_z)")
                .frame(width: UIScreen.main.bounds.width - 20, height: 250)
                .cornerRadius(10)
                .scaledToFill()
        }
    }
}

struct PhotoCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
