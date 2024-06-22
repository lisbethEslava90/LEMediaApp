//
//  DefaultMovie.swift
//  LEMediaApp
//
//  Created by Lisbeth Eslava on 22/06/24.
//

import SwiftUI

struct DefaultMovie: View {
    let widthM: CGFloat
    let heightM: CGFloat

    var body: some View {
        Image("LE_LOGO")
            .resizable()
            .frame(width: widthM, height: heightM)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    DefaultMovie(widthM: 140.0, heightM: 180.0)
}
