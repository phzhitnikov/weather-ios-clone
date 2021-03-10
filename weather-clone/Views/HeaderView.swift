import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(self.viewModel.city.name)
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.all, 0)
            Text(self.viewModel.currentWeatherString ?? "")
                .font(.body)
                .fontWeight(.light)
                .padding(.bottom, 4)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(id: 1, name: "Saint-Petersburg", lat: 59.9167, long: 30.25)
        let viewModel = WeatherViewModel(city)
        return HeaderView(viewModel: viewModel)
    }
}
