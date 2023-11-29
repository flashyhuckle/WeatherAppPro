import SwiftUI

struct FavoritesVCSUI: View {
    @Environment(\.dismiss) private var dismiss
    
    var didTapCell: ((String) -> Void)?
    @State var viewModel: FavoritesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.favorites.favoritesArray, id: \.self) { city in
                Button(city) {
                    self.didTapCell?(city)
                    self.dismiss()
                }
            }
            .onDelete(perform: deleteItems)
            .navigationTitle("Favorite cities")
        }
    }
    func deleteItems(at offsets: IndexSet) {
        if let number = offsets.first {
            viewModel.favorites.buttonTapped(viewModel.favorites.favoritesArray[number])
//            viewModel.favorites.favoritesArray.remove(atOffsets: offsets)
        }
    }
}

//#Preview {
//    FavoritesVCSUI(favorites: ["london", "paris"])
//}
