import SwiftUI

struct CityList: View {
    // TODO: use storage
    // TODO: add/delete cities
    var cities: [City]
    
    var body: some View {
        List {
            Text("Test")
//            ForEach(self.cities) { city in
//                Text(city.name)
//            }
        }
    }
}

//struct CityList_Previews: PreviewProvider {
//    static var previews: some View {
//        CityList()
//    }
//}
