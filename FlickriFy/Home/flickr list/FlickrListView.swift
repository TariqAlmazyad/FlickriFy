//
//  FlickrListView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/2/20.
//

import SwiftUI

struct FlickrListView: View {
    @StateObject  var viewModel:  PhotosViewModel
    @State var rating: Double = Double.random(in: 0..<5)
    var body: some View {
        ZStack { // <- make ZSTack to make the bg color dark
            NavigationView{ // <-- added navigation view to display title
                ZStack{ // <- for displaying PickerView on the top of the View
                    Color(#colorLiteral(red: 0.1138496622, green: 0.1236990467, blue: 0.1547537446, alpha: 1))
                        .ignoresSafeArea()
                    ScrollView { // vertical scrollView
                        PhotosConfigureView(isPhotoPickerVisible: $viewModel.isPhotoPickerVisible,
                                            selection: $viewModel.numOfSelectedPhotos,
                                            isFilterPickerVisible: $viewModel.isFilterPickerVisible,
                                            selectedFilter: $viewModel.filterSelected)
                        
                        if viewModel.isLoading { // when the VM is loading , show the loading indicator.
                            
                            VStack { // <-- VSTack animationView
                                LottieAnimationView(jsonFileName: .constant(.flickerLoading)) //<- UIKit custom animationView
                                    .frame(width: 100, height: 100)
                                Text("Please wait...")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                    .padding(.top)
                            }
                            
                        } else {
                            VStack{
                                Spacer()
                                ForEach(viewModel.filteredPhotos, id:\.self) { photo in
                                    NavigationLink(
                                        destination: PhotoDetailView(photo: photo, rating: $rating),
                                        label: {
                                            PhotoCellView(photo: photo)
                                        })
                                        
                                        .padding(.vertical, 12)
                                }
                                Spacer()
                            }
                        }// end if else
                        
                    }// end scrollView
                    .navigationBarTitle("FlickrFy", displayMode: .inline)
                    // if is pickerView visible , then blur the bg
                    .blur(radius: viewModel.isPickerVisible ? 20 : 0)
                    // and disable the view interaction
                    .disabled(viewModel.isPickerVisible ? true : false)
                    
                    PhotosPickerView(selection: $viewModel.numOfSelectedPhotos,
                                     isPickerVisible: $viewModel.isPhotoPickerVisible, completion: {
                                        viewModel.getPhotos(numPhotos: viewModel.numOfSelectedPhotos)
                                     })
                        .opacity(viewModel.isPhotoPickerVisible ? 1 : 0)
                    
                    FilterPickerView(selectedFilter: $viewModel.filterSelected,
                                     isPickerVisible: $viewModel.isFilterPickerVisible, completion: {
                                        viewModel.getPhotos(numPhotos: viewModel.numOfSelectedPhotos)
                                     })
                        .opacity(viewModel.isFilterPickerVisible ? 1 : 0)
                    
                }// end ZStack
                
            }
            
        }.statusBarStyle(.lightContent)
        
        .onAppear{
            viewModel.getPhotos(numPhotos: viewModel.numOfSelectedPhotos)
        }
    }
}

struct FlickrListView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarHomeView()
    }
}


struct PhotosPickerView: View {
    @Binding var selection: Int
    @Binding var isPickerVisible: Bool
    var completion: () -> Void
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Button(action: {
                    withAnimation{
                        isPickerVisible.toggle()
                        completion()
                    }
                }, label: {
                    Text("Save change")
                        
                        .foregroundColor(Color(.lightGray))
                        .padding()
                })
                .foregroundColor(Color.white)
            }.padding()
            
            Picker("Number of photos", selection: $selection) {
                ForEach(0..<1000) { num in
                    Text("\(num) \(num == 1 ? "photo" : "photos")")
                        
                        .foregroundColor(Color(.white))
                        
                        .foregroundColor(Color.white)
                    
                }
            }
            .frame(height: proxy.size.height)
        }
        
    }
}


struct FilterPickerView: View {
    @Binding var selectedFilter: FilterPicker
    @Binding var isPickerVisible: Bool
    var completion : () -> Void
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Button(action: {
                    withAnimation{
                        isPickerVisible.toggle()
                        completion()
                    }
                }, label: {
                    Text("Save change")
                        .foregroundColor(Color.white)
                }).padding()
                
                Picker("Number of photos", selection: $selectedFilter) {
                    ForEach(FilterPicker.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                            .foregroundColor(Color.white)
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
                    Text("\(selection) \(selection == 1 ? "photo" : "photos")")
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
