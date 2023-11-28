//
//  FavoritesVCSUI.swift
//  WeatherAppPro
//
//  Created by Marcin Głodzik on 27/11/2023.
//

import SwiftUI

struct FavoritesVCSUI: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var favorites: [String] = {
        let userDefaults: UserDefaults = .standard
        if let favorite = userDefaults.array(forKey: "favorites") as? [String] {
            return favorite
        } else {
            return [String]()
        }
    }()
    
    var body: some View {
        List {
            ForEach(favorites, id: \.self) {
                Button($0) {
                    self.dismiss()
                }
            }
            .navigationTitle("Favorite cities")
        }
    }
}

#Preview {
    FavoritesVCSUI(favorites: ["london", "paris"])
}
