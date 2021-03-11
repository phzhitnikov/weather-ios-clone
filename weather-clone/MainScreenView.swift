import SwiftUI
import CoreLocation

struct MainScreenView: View {
    @EnvironmentObject var cityStore: CityStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.cityStore.cities) { city in
                    NavigationLink(destination: CityWeatherView(city: city)) {
                        Text(city.name)
                    }
                }
                .onDelete { indexSet in
                    self.cityStore.cities.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle(Text("Select city"))
            .navigationBarItems(trailing: Button(action: {},
                                                 label: { Image(systemName: "plus").imageScale(.large) })
            )
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
