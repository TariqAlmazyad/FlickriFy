//
//  FavoritePhotosView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/3/20.
//

import SwiftUI

struct FavoritePhotosView: View {
    
    @StateObject private var firebaseVM = FirebaseViewModel()
    
    var body: some View {
        VStack(alignment: .center){
            List{
                ForEach(firebaseVM.photos) { photo in
                    FlickrFyRemoteImage(urlString: "\(photo.url_z)")
                        .frame(width: 330, height: 200)
                }.onDelete(perform: firebaseVM.deleteItem)
            }.onChange(of: firebaseVM.photos, perform: { value in
                DispatchQueue.main.async {
                    firebaseVM.fetchPhotosFromFirebase()
                }
            })
        }.onAppear{
            firebaseVM.fetchPhotosFromFirebase()
        }
        
    }
}


struct FavoritePhotosView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePhotosView()
            .preferredColorScheme(.dark)
    }
}
