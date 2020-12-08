import SwiftUI



struct ContentView: View {

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 10)
                .foregroundColor(.red)
            
            CompassView()
                .shadow(radius: 2)
                .padding(5)
        }
    }
}
