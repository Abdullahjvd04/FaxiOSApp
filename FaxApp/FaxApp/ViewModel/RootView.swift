//
//  RootView.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import SwiftUI

struct RootView: View {
    @StateObject private var navVM = NavigateViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {

            switch navVM.currentScreen {
            case .splash:
                SplashView()
                    .environmentObject(navVM)

            case .home:
                HomeView()
                    .environmentObject(navVM)

            case .document:
                DocumentView()
                    .environmentObject(navVM)

            case .setting:
                SettingsView()
                    .environmentObject(navVM)

            }

            if navVM.currentScreen == .home ||
               navVM.currentScreen == .document ||
               navVM.currentScreen == .setting {

                BottomView()
                    .environmentObject(navVM)
            }

            if navVM.showProView {
                PremiumView()
                    .environmentObject(navVM)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            if navVM.showCoverPage {
                CoverpageView()
                    .environmentObject(navVM)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            if navVM.showImagePreviewView {
                ImagePreview()
                    .environmentObject(navVM)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
                        
            if navVM.showMoreFunctionsView {
                MoreFunctionsView()
                    .environmentObject(navVM)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            if navVM.ShowEditView {
                EditView()
                    .environmentObject(navVM)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
       
        }
    }
}



