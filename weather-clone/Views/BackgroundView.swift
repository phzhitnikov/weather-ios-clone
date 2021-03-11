import SwiftUI

struct BackgroundView: View {
    var fill = Color(.white)
    
    var body: some View {
        Rectangle()
            .fill(self.fill)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
