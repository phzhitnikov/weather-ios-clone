import SwiftUI

struct SearchBar: View {
    var placeholder: String
    
    @Binding var searchText: String
    @Binding var inProgress: Bool
    
    var onCommit: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField(self.placeholder, text: self.$searchText, onCommit: {
                    self.inProgress = true
                    self.onCommit()
                })
                    .foregroundColor(.primary)
                
                Group {
                    if !self.inProgress {
                        Button(action: { self.searchText = "" }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    else {
                        Image(systemName: "hourglass").spinning()
                    }
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
        .disabled(self.inProgress)
    }
}

struct SearchCityView: View {
    @State private var searchText: String = ""
    @State private var results = [CitySearchResult]()
    @Binding var isShowing: Bool
    @State var isSearching: Bool = false
    
    @EnvironmentObject var store: CityStore
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(placeholder: "By name, state and country code", searchText: self.$searchText, inProgress: self.$isSearching) {
                    self.isSearching = true
                    OpenWeatherMapAPIClient.searchCity(self.searchText, callback: { data, error in
                        self.isSearching = false
                        if let data = data {
                            self.results = data
                        }
                    })
                }
                
                List {
                    ForEach(self.results) { result in
                        return Text("\(result.name) (\(result.country))")
                            .onTapGesture {
                                let city = City(name: result.name, lat: result.lat, long: result.lon)
                                self.store.add(city)
                                self.isShowing = false
                        }
                    }
                }
            }.navigationBarTitle(Text("City search"))
        }
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityView(isShowing: .constant(true))
    }
}
