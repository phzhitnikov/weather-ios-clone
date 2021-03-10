import SwiftUI
import CoreLocation

// FIXME: global vars are no-no
var cities: [City] = [
    City(id: 1, name: "Saint-Petersburg", lat: 59.9167, long: 30.25)
]

struct FooterView: View {
    @State private var showCitiesList: Bool = false
    
    var body: some View {
        Image(systemName: "list.dash")
        .imageScale(.large)
        .onTapGesture { self.showCitiesList = true }
        .popover(isPresented: self.$showCitiesList) { CityList(cities: cities) }
    }
}

struct MainScreenView: View {
    
    var body: some View {
        Section(footer: FooterView())
        {
            // TODO: cities on pages
            CityWeatherView(city: cities[0])
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
