//
//  ContentView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @State private var photosSelection: Int = 0
    @State private var isPhotoPickerVisible: Bool = false
    
    @State private var filterSelected: FilterPicker = .views
    @State private var isFilterPickerVisible: Bool = false
    
    @StateObject var viewModel = PhotosListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView{
                ZStack{
                    Color(#colorLiteral(red: 0.1138496622, green: 0.1236990467, blue: 0.1547537446, alpha: 1))
                        .ignoresSafeArea()
                    ScrollView {
                        PhotosConfigureView(isPhotoPickerVisible: $isPhotoPickerVisible,
                                            selection: $photosSelection,
                                            isFilterPickerVisible: $isFilterPickerVisible,
                                            selectedFilter: $filterSelected)
                        
                    }.blur(radius: isPhotoPickerVisible || isFilterPickerVisible ? 20 : 0)
                    //                LottieAnimationView(jsonFileName: .constant(.flickerLoading))
                    //                    .frame(width: 100, height: 100)
                    
                    PhotosPickerView(selection: $photosSelection,
                                     isPickerVisible: $isPhotoPickerVisible)
                        .opacity(isPhotoPickerVisible ? 1 : 0)
                    FilterPickerView(selectedFilter: $filterSelected,
                                     isPickerVisible: $isFilterPickerVisible)
                        .opacity(isFilterPickerVisible ? 1 : 0)
                }
                .navigationBarTitle("Discovery", displayMode: .large)
            }.onAppear{
                viewModel.getPhotos()
            }
        }.statusBarStyle(.lightContent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct PhotosPickerView: View {
    @Binding var selection: Int
    @Binding var isPickerVisible: Bool
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topTrailing) {
                Button(action: {
                    withAnimation{
                        isPickerVisible.toggle()
                    }
                }, label: {
                    Text("Save change")
                        .foregroundColor(Color(.lightGray))
                }).padding()
                
                Picker("Number of photos", selection: $selection) {
                    ForEach(1 ..< 1000) { num in
                        Text("\(num) \(num == 1 ? "photo" : "photos")")
                            .foregroundColor(Color(.lightGray))
                    }
                }
                .frame(height: proxy.size.height)
            }
        }
    }
}

struct FilterPickerView: View {
    @Binding var selectedFilter: FilterPicker
    @Binding var isPickerVisible: Bool
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topTrailing) {
                Button(action: {
                    withAnimation{
                        isPickerVisible.toggle()
                    }
                }, label: {
                    Text("Save change")
                        .foregroundColor(Color(.lightGray))
                }).padding()
                
                Picker("Number of photos", selection: $selectedFilter) {
                    ForEach(FilterPicker.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                            .foregroundColor(Color(.lightGray))
                    }
                }
                .frame(height: proxy.size.height)
            }
        }
    }
}

enum FilterPicker: String, CaseIterable  {
    case views  = "Top Views"
    case postedDate = "Recent"
}

struct PhotosConfigureView: View {
    
    @Binding var isPhotoPickerVisible: Bool
    @Binding var selection: Int
    @Binding var isFilterPickerVisible: Bool
    @Binding var selectedFilter: FilterPicker
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action: { withAnimation{
                isPhotoPickerVisible.toggle()
            }}, label: {
                HStack {
                    Text("\(selection + 1) \(selection == 1 ? "photo" : "photos")")
                    Image(systemName: "chevron.down")
                    
                }
                .frame(width: 160, height: 50)
                .background(Color(#colorLiteral(red: 0.2684438825, green: 0.2685533166, blue: 0.2822875977, alpha: 1)))
                .cornerRadius(25)
                
            })
            
            Button(action: { withAnimation{
                isFilterPickerVisible.toggle()
            }}, label: {
                HStack {
                    Text(selectedFilter.rawValue)
                    Image(systemName: "line.horizontal.3.decrease")
                }
                .frame(width: 160, height: 50)
                .background(Color(#colorLiteral(red: 0.2684438825, green: 0.2685533166, blue: 0.2822875977, alpha: 1)))
                .cornerRadius(25)
            })
            Spacer()
        }
        .font(.system(size: 14, weight: .semibold))
        .foregroundColor(Color(.lightGray))
        .padding()
        .cornerRadius(10)
        .padding(16)
    }
}
