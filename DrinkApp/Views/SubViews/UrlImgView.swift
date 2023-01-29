

import SwiftUI

struct UrlImgView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    static var defaultImage = UIImage(named: "StrawberryLimeade")
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImgView.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: 210, height: 210)
    }

    
}

struct UrlImgView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImgView(urlString: nil)
    }
}
