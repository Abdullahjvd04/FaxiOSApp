//
//  ImagePreview.swift
//  FaxApp
//
//  Created by Ios Dev on 25/02/2026.
//

import SwiftUI

struct ImagePreview: View {
    @EnvironmentObject private var navVM: NavigateViewModel

    var body: some View {
        ZStack{
            Color(.whiteClr)
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button(action:{
                        navVM.showImagePreviewView = false

                    }){
                        Image(.exitImg)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    Button(action:{
                        navVM.ShowEditView = true
                    }){
                        HStack{
                            Text("Edit")
                                .font(AppFont.medium.size(20))
                                .foregroundColor(.whiteClr)
                        }
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(RoundedRectangle(cornerRadius: 6).fill(.darkClr))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                
                VStack{
                    Image(uiImage: navVM.currentImage)
                        .resizable()
                        .scaledToFit()
                    
                }
                .frame(width: Constants.width * 0.8, height: Constants.height * 0.5)
                
                
                
            }
            .padding()
            .frame(maxWidth: .infinity,alignment: .top)
            .background(RoundedRectangle(cornerRadius: 20).fill(.offWhiteClr))
            .padding()
            
            
        }
    }
}

#Preview {
    ImagePreview()
}
