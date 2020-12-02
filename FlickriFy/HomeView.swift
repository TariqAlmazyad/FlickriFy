//
//  ContentView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @StateObject var viewModel = PhotosViewModel()
    
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
