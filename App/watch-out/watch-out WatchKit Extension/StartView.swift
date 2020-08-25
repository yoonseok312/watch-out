import SwiftUI

struct StartView: View {
  
  @State var nextScreenShown = false
  
  var body: some View {

    VStack{
        Image("3_c_r")
        .resizable()
        .frame(width: 112.0, height: 112.0)
        Spacer()
        NavigationLink(destination: ContentView()) {
            Text("위험신호 감지 시작 ").bold()
        }
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

