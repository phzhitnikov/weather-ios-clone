import SwiftUI

struct CityWeatherView: View {
    @ObservedObject var weather: WeatherViewModel
    
    init(city: City) {
        self.weather = WeatherViewModel(city)
    }
    
    var body: some View {
        Group {
            if self.weather.isLoading {
                Image(systemName: "hourglass").imageScale(.large).spinning()
            } else {
                ZStack {
                    BackgroundView()  // TODO: select background based on day/night/weather
                    VStack {
                        HeaderView(viewModel: self.weather)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            CurrentTempView(viewModel: self.weather)
                            Divider()
                            HourlyForecastSectionView(weather: self.weather.hourlyWeather)
                            Divider()
                            DailyForecastSectionView(data: self.weather.dailyWeather)
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 2) {
                                ForEach(self.weather.details.map { $0 }, id: \.title) { item in
                                    // TODO: hide items with empty text
                                    Group {
                                        WeatherDetailView(title: item.title, text: item.text)
                                        Divider()
                                    }
                                }
                            }.padding(.horizontal, 8)
                        }
                    }
                }
            }
        }.onAppear {
            self.weather.fetchData()
        }
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let city = City(name: "Saint-Petersburg", lat: 59.9167, long: 30.25)
        return CityWeatherView(city: city)
    }
}
