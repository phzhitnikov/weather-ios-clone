import SwiftUI

struct FallbackSystemImage: View {
    var source: String?
    var fallbackSystemIcon: String
    
    
    var body: some View {
        if let icon = self.source {
            return Image(icon).resizable()
        }
        
        return Image(systemName: self.fallbackSystemIcon).resizable()
    }
}
