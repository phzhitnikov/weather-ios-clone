import SwiftUI
import CoreLocation

struct MainScreenView: View {
    @EnvironmentObject var cityStore: CityStore
    @State var showSearchView: Bool = false
    
    var body: some View {
        // MARK: - City selection
        NavigationView {
            List {
                ForEach(self.cityStore.cities) { city in
                    NavigationLink(destination: CityWeatherView(city: city),
                                   label: { Text(city.name) })
                }
                .onDelete { indexSet in
                    self.cityStore.cities.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle(Text("Select city"))
            .navigationBarItems(trailing: Button(action: { self.showSearchView = true },
                                                 label: { Image(systemName: "plus").imageScale(.large) })
            )
        }

        // MARK: - Search screen
        .sheet(isPresented: self.$showSearchView) {
            SearchCityView(isShowing: self.$showSearchView)
                .environmentObject(self.cityStore)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
