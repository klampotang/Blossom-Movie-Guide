import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> some UIView {
        webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let baseURLString = youtubeBaseURL,
              let baseURL = URL(string: baseURLString) else {return}
        let fullURL = baseURL.appending(path: videoId)
        
        var request = URLRequest(url: fullURL)
                
        // 2. Set a valid Referer header
        request.setValue("https://github.com/BlossomBuild/BlossomMovie/tree/section-3-5/BlossomMovie", forHTTPHeaderField: "Referer")
                
        webView.load(request)
    }
}
