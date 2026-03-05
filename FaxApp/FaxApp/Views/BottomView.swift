//
//  BottomView.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import SwiftUI

struct BottomView: View {
    @EnvironmentObject var navVM: NavigateViewModel

    var body: some View {
        HStack(spacing: 10) {
            tabButton(screen: .home, selectedImage: .homeSelect, normalImage: .homeNot)
            tabButton(screen: .document, selectedImage: .documentSelect, normalImage: .documentNot)
            tabButton(screen: .setting, selectedImage: .settingSelect, normalImage: .settingNot)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    private func tabButton(
        screen: Screen,selectedImage: ImageResource,normalImage: ImageResource) -> some View {
        Button {
            navVM.currentScreen = screen
        } label: {
            VStack(spacing: 4) {
                Image(navVM.currentScreen == screen ? selectedImage : normalImage)
                indicatorView(isSelected: navVM.currentScreen == screen)
            }
        }
    }

    private func indicatorView(isSelected: Bool) -> some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(isSelected ? .darkClr : .clear)
    }
}

#Preview {
    BottomView()
}

