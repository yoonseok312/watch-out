
import SwiftUI

struct Alert_B: View {
    static let gradientStart = Color(red: 255.0 / 255, green: 168.0 / 255, blue: 0.0 / 255)
    static let gradientEnd =  Color(red: 255 / 255, green: 198 / 255, blue: 0 / 255)

    var body: some View {
        VStack{
               Spacer()
            HStack{
                Image(systemName: "dot.radiowaves.left.and.right").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,1)
                Text("사용자 이름감지").font(.system(size: 23, weight: .bold))
    
                 }
            Spacer()
        
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 23, style: .continuous)
                               .fill(LinearGradient(
                                 gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                 startPoint: .init(x: 0.0, y: 0.0),
                                 endPoint: .init(x: 0.5, y: 0.6)
                               ))
                               .frame(width: 185, height: 120)
                    VStack(alignment: .leading) {
                        Text("근처에서").font(.system(size: 18, weight: .black)).padding(.vertical,7).foregroundColor(Color.init(red: 255, green: 255, blue: 255))
                        
                        Text("수지님을 ").font(.system(size: 37, weight: .black)).padding(.horizontal,10).foregroundColor(Color.init(red: 0, green: 0, blue: 0))
                        
                        HStack(alignment:.lastTextBaseline){
                            Text("가 들렸습니다").font(.system(size: 18, weight: .black)).padding(.vertical,7).padding(.leading,60).foregroundColor(Color.init(red: 255, green: 255, blue: 255))
                        }
                    }
                   
                    
                }
           
                 }
        }
    }
}

struct Alert_B_Previews: PreviewProvider {
    static var previews: some View {
        Alert_B()
    }
}


