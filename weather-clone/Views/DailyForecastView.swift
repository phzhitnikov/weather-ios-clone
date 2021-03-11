import SwiftUI

struct DailyForecastView: View {
    var data: MultiWeather
    
    private var dayString: String {
        return self.data.dt?.asDate().monthDayFull() ?? ""
    }
    
    var body: some View {
        HStack {
            Text(self.dayString)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            FallbackSystemImage(source: self.data.weather?.first?.icon, fallbackSystemIcon: "questionmark.circle")
                .frame(width: 30, height: 30)
            
            // FIXME: make temps equal width, so they are aligned in column in pretty way
            Text(self.data.temp?.max?.formatted() ?? "")
                .frame(minWidth: 40)
            Spacer().frame(width: 34)
            Text(self.data.temp?.min?.formatted() ?? "")
                .frame(minWidth: 40)
                .foregroundColor(Color.gray)
        }.padding(.horizontal, 24)
    }
}

struct DailyForecastSectionView: View {
    let data: [MultiWeather]?
    
    var body: some View {
        VStack {
            ForEach(self.data ?? []) { data in
                DailyForecastView(data: data)
            }
        }
    }
}


// MARK: - Previews
struct DailyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        let data = MultiWeather()
        return DailyForecastView(data: data)
    }
}

struct DailyForecastSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let data = [MultiWeather()]
        return DailyForecastSectionView(data: data)
    }
}
