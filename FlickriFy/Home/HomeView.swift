//
//  ContentView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import SwiftUI
import Firebase
import LNPopupUI

struct HomeView: View {
    
    @StateObject var viewModel = PhotosViewModel()
    @State private var isPopupOpen: Bool = false
    var body: some View {
        // main tabView
        TabView {
            // tabBar item 0
            FlickrListView(viewModel: viewModel)
                .tabItem {
                    Text("List")
                    Image(systemName: "list.bullet")}
            // tabBar item 1
            PhotosMapView(viewModel: viewModel)
                .tabItem {
                    Text("Map")
                    Image(systemName: "map.fill")
                }

        }.accentColor(.white)
        
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
            
        }
        
        // popUp view : when user taps on the bar , it displays favorites
        .popup(isBarPresented: .constant(true), isPopupOpen: $isPopupOpen) {
            FavoritePhotosView()
        }
        // tabBar modifiers
        .popupInteractionStyle(.drag)
        .popupBarCustomView(wantsDefaultTapGesture: true, wantsDefaultPanGesture: true,
                            wantsDefaultHighlightGesture: false) {
            // displays message in the tabBar
            VStack(spacing: 12){
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 5)
                HStack(spacing: 12){
                    Text("Favorite photos")
                        .font(.system(size: 16, weight: .light))
                        .padding(6)
                    Image(systemName: "star.fill")
                        .font(.system(size: 24))
                }.padding(.bottom, 6)
                .foregroundColor(Color(.lightGray))
            }.frame(height: 60)
            .padding(.top, 8)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
