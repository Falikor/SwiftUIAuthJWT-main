//
//  RootView.swift
//  SwiftClient
//
//  Created by 19494115 on 17.04.2022.
//

import SwiftUI

struct RootView {
    static func change(to view: AnyView) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? UIWindowSceneDelegate else {
                  return
              }
        let contentView = view
        sceneDelegate.window??.rootViewController = UIHostingController(rootView: contentView)
    }
}
