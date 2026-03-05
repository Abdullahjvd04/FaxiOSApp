//
//  SplashView.swift
//  FaxApp
//
//  Created by Ios Dev on 24/02/2026.
//

import SwiftUI

struct SplashView: View {

    @EnvironmentObject var navVM: NavigateViewModel

    var body: some View {
        VStack(spacing: 15){
            Image(.splashImg)

            Text("New Fax")
                .font(AppFont.regular.size(46))
                .foregroundColor(.whiteClr)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RoundedRectangle(cornerRadius: 0).fill(.darkClr))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    navVM.currentScreen = .home
                    navVM.showProView = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
