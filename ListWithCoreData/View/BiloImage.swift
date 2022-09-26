//
//  BiloImage.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import SwiftUI
import struct KingfisherSwiftUI.KFImage
import struct Kingfisher.AnyModifier

@ViewBuilder
func BiloImage(withPath path: String?) -> KFImage {
    
    let modifier = AnyModifier { request in
        var modifiableRequest = request
        modifiableRequest.httpMethod = "GET"
        modifiableRequest.setValue("<#AccessToken#>", forHTTPHeaderField: "Authorization")
        return modifiableRequest
    }
    
    let url = URL(string: path ?? "")
    
    KFImage(
        url,
        options: [
            .requestModifier(modifier),
            .transition(.fade(0.3))]
    )
    .placeholder {
        // Placeholder while downloading.
        Rectangle()
            .cornerRadius(8.0)
            .opacity(0.3)
//        Image(systemName: "arrow.2.circlepath.circle")
//            .font(.largeTitle)
//            .opacity(0.3)
    }
    .onSuccess { r in
        // r: RetrieveImageResult
        print("success: \(r)")
    }
    .onFailure { e in
        // e: KingfisherError
        print("failure: \(e)")
    }
    
}
