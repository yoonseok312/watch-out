import SwiftUI

struct StartView: View {
  
  @State var nextScreenShown = false
  
  var body: some View {
    
    ZStack {
      Circle()
        .fill(Color(000099))
      Circle()
        .fill(Color(0x0000ff))
        .frame(width: 120, height: 120)
      Circle()
        .fill(Color(0x6666ff))
        .frame(width: 80, height: 80)
      VStack {
        NavigationLink(destination: ContentView()) {
          Text("Start")
            .bold()
            .onTapGesture {
              self.nextScreenShown = true
              WKInterfaceDevice.current().play(.notification)
              
          }
        }
      }
      //.buttonStyle(PlainButtonStyle())
      
    }
    
  }
}

struct StartView_Previews: PreviewProvider {
  static var previews: some View {
    StartView()
  }
}

extension Color {
  init(_ hex: UInt32, opacity:Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
  }
}

