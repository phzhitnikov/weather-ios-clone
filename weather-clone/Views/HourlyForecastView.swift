import SwiftUI
import Foundation


struct HourlyForecastView: View {
    var data: Weather
    
    private var hour: String {
        return self.data.dt?.asDate().hour() ?? ""
    }
    
    var body: some View {
        VStack {
            Text(self.hour)
            FallbackSystemImage(source: self.data.weather?.first?.icon, fallbackSystemIcon: "questionmark.circle")
                .frame(width: 30, height: 30)
            Text(self.data.temp?.formatted() ?? "")
        }
    }
}


struct HourlyForecastSectionView: View {
    var weather: [Weather]?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(weather ?? []) { data in
                    HourlyForecastView(data: data)
                    Spacer().frame(width: 24)
                }
            }.padding(.horizontal, 24)
        }
    }
}


// MARK: - Previews

struct HourlyForecastSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let data = (0...24).map {
            Weather(
                dt: Double($0 * 3600)
            )
        }
        return HourlyForecastSectionView(weather: data)
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let data = Weather(
            dt: 1615222800
        )
        return HourlyForecastView(data: data)
    }
}

