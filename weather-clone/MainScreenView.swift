import SwiftUI
import CoreLocation

struct MainScreenView: View {
    @EnvironmentObject var cityStore: CityStore
    @State var showCitiesList: Bool = false
    
    var body: some View {
        // TODO: cities on pages
        // TODO: footer
        CityWeatherView(city: self.cityStore.cities[1]!)
        
//        Image(systemName: "list.dash")
//        .imageScale(.large)
//        .onTapGesture { self.showCitiesList = true }
//        .popover(isPresented: self.$showCitiesList) { CityList(cities: cities) }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
