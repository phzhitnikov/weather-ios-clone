import SwiftUI

struct WeatherDetailView: View {
    var title: String
    var text: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title.uppercased()).foregroundColor(.gray)
            Text(self.text ?? "").font(Font.system(.title))
        }
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(title: "Title", text: "Testme 123")
    }
}
