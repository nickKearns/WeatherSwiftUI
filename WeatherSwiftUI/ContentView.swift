import SwiftUI


//struct SearchBar: View {
//    @Binding var searchText: String
//
//    @State private var isEditing = false
//
//    var body: some View {
//        HStack {
//
//            TextField("Enter City Name", text: $searchText)
//                .padding(7)
//                .padding(.horizontal, 25)
//                .background(Color(.systemGray3))
//                .cornerRadius(8)
//                .padding(.horizontal, 10)
//                .onTapGesture {
//                    self.isEditing = true
//                }
//
//            if isEditing {
//                Button(action: {
//                    self.isEditing = false
//                    self.searchText = ""
//                }) {
//                    Text("Cancel")
//                }
//                .padding(.trailing, 10)
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
//        }
//    }
//}

struct ContentView: View {
    
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    SearchBar(text: $viewModel.searchTerm,
                              onSearchButtonClicked: viewModel.onSearchTapped)
                    List(viewModel.games, id: \.title) { game in
                        Text(verbatim: game.title)
                    }
                }
            }
            .navigationBarTitle(Text("Games"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
