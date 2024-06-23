//
//  Video.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 23/06/24.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoUrl: URL?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoUrl = videoUrl else { return }
        let request = URLRequest(url: videoUrl)
        uiView.load(request)
        uiView.contentMode = .scaleAspectFit
    }
}

struct VideoView: View {
    let videoUrl: URL?
    @State private var isLoading: Bool = true

    var body: some View {
        ZStack(alignment: .center) {
            YouTubeView(videoUrl: videoUrl)
                .frame(maxWidth: .infinity, maxHeight: 300)
        }
    }
}

//#Preview {
//    VideoView(id: "RY5aH21ohU4")
//}
