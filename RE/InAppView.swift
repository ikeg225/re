//
//  InAppView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/18/22.
//

import SwiftUI

struct InAppView: View {
    var body: some View {
        TabView {
            RecordView()
                .tabItem() {
                    Image(systemName: "house")
                        .foregroundColor(.red)
                }
            RememberView()
                .tabItem() {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.red)
                }
            ProfileView()
                .tabItem() {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.red)
                }
        }
        .onAppear() {
            let image = UIImage.gradientImageWithBounds(
                bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 8),
                colors: [
                    UIColor.clear.cgColor,
                    UIColor.black.withAlphaComponent(0.1).cgColor
                ]
            )

            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .white
                    
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = image

            UITabBar.appearance().standardAppearance = appearance
        }
    }
}

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

struct InAppView_Previews: PreviewProvider {
    static var previews: some View {
        InAppView()
    }
}
