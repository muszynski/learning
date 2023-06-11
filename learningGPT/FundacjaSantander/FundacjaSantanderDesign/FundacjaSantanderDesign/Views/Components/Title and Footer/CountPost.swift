// kod dla komponentu dla statystyk
// widok używany do debugowanai
import SwiftUI

struct CountPost: View {
    
    @State var countPost : Int
    @State var postUpdated : Int
    @State var postThumb : Int
    
    var body: some View {
        VStack {
            Text("Developer mode for debugging")
                .font(.custom("SantanderText-Regular", size: 10))
                .foregroundColor(.gray)
                .padding(.bottom, -2)
            HStack(spacing: 10) {
                Image(systemName: "doc.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 13)
                Text(String(countPost))
                    .font(.custom("SantanderText-Regular", size: 13))

                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 13)
                Text(String(postUpdated))
                    .font(.custom("SantanderText-Regular", size: 13))

                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 13)
                Text(String(postThumb))
                    .font(.custom("SantanderText-Regular", size: 13))
            }
        }
    }
}

struct CountPost_Previews: PreviewProvider {
    static var previews: some View {
        CountPost(countPost: 12, postUpdated: 10, postThumb: 12)
    }
}


