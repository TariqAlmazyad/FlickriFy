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
        uiView.rating = rating
        uiView.isUserInteractionEnabled = false
        // Autoresize Cosmos view according to it intrinsic size
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        uiView.text = String(format: "%.2f", uiView.rating)
        // Change Cosmos view settings here
        uiView.settings.starSize = starsSize
        uiView.settings.textColor = .white
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
