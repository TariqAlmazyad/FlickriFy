//
//  MyCosmosView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/2/20.
//

import SwiftUI
import Cosmos

// A SwiftUI wrapper for Cosmos view
struct RatingView: UIViewRepresentable {
    @Binding var rating: Double
    @Binding var starsSize: Double

    func makeUIView(context: Context) -> CosmosView {
        CosmosView()
    }

    func updateUIView(_ uiView: CosmosView, context: Context) {
        uiView.rating = Double.random(in: 0..<5)
        
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      
        // Change Cosmos view settings here
        uiView.settings.starSize = starsSize
    }
}

struct MyRatingView: View {
    @State var rating = 3.0
    var body: some View {
        RatingView(rating: $rating, starsSize: .constant(10))
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        MyRatingView()
    }
}
