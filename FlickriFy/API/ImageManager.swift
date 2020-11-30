//
//  ImageManager.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import SwiftUI

final class ImageManager: ObservableObject{
    @Published var image: Image? = nil
    func load(fromURLString urlString: String){
        NetworkingManager.shared.downloadImage(fromURLString: urlString) { [weak self] uiImage in
            guard let self = self else {return}
            guard let uiImage = uiImage else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct RemoteImage: View {
    var image: Image?
    var body: some View {
        image?.resizable() ?? Image(systemName: "photo")
    }
}

struct FlickrRemoteImage: View {
    @StateObject var imageLoader = ImageManager()
    let urlString: String
    var body: some View{
        RemoteImage(image: imageLoader.image)
            .onAppear{
                imageLoader.load(fromURLString: urlString)
            }
    }
}
