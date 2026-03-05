//
//  DocumentPrevire.swift
//  FaxApp
//
//  Created by Ios Dev on 26/02/2026.
//

import SwiftUI

struct DocumentPreview: View {
    @EnvironmentObject private var navVM: NavigateViewModel

    var body: some View {
        ZStack{
            Color(.whiteClr)
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Button(action:{
                        navVM.showDocumentView = false

                    }){
                        ZStack{
                            Image(.redbback)
                            Image(.crossimg)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                
                }
                .frame(maxWidth: .infinity)
                
                VStack{
                    Image(.add2)
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
    DocumentPreview()
}
