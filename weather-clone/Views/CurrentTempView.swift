import SwiftUI

struct CurrentTempView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            // FIXME
            Text(self.viewModel.currentWeather?.temp?.formatted() ?? "")
                .font(.system(size: 86))
                .fontWeight(.thin)
            HStack {
                // FIXME: hacky
                Text("H:\(self.viewModel.maxTempToday?.formatted() ?? "")")
                Text("L:\(self.viewModel.minTempToday?.formatted() ?? "")")
            }
        }
        .padding(.vertical, 24)
    }
}

struct CurrentTempView_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(name: "Saint-Petersburg", lat: 59.9167, long: 30.25)
        let viewModel = WeatherViewModel(city)
        return CurrentTempView(viewModel: viewModel)
    }
}
