//
//  LottieAnimationView.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import SwiftUI
import Lottie

enum AnimationType: String, CaseIterable{
    case error404page
    case peopleWithMobilePhones
    case illustrationAnimation
    case flickerLoading
    case flickLogoReveal
}

struct LottieAnimationView: UIViewRepresentable {
   
    @Binding var jsonFileName: AnimationType
    
    func makeUIView(context: Context) -> AnimationView {
        let animationView = AnimationView.init(name: jsonFileName.rawValue)
        animationView.loopMode = .loop
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) { }
    
}

struct LottieAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationView(jsonFileName: .constant(.flickerLoading))
    }
}
