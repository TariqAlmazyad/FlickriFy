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
        TabView {
            PhotosMapView(viewModel: viewModel)
                .tabItem {
                    Text("Map")
                    Image(systemName: "map.fill")
                    
                }
            FlickrListView(viewModel: viewModel)
                .tabItem {
                    Text("List")
                    Image(systemName: "list.bullet")}
            
        }.accentColor(.white)
        
        .popup(isBarPresented: .constant(true), isPopupOpen: $isPopupOpen) {
            
        }
        .popupInteractionStyle(.drag)
        .popupBarCustomView(wantsDefaultTapGesture: true, wantsDefaultPanGesture: true,
                            wantsDefaultHighlightGesture: false) {
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
