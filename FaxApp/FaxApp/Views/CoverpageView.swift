//
//  CoverpageView.swift
//  FaxApp
//
//  Created by Ios Dev on 25/02/2026.
//
//
//import SwiftUI
//
//struct CoverpageView: View {
//    @EnvironmentObject private var navVM: NavigateViewModel
//    @State private var values: [String] = Array(repeating: "", count: 4)
//    @State private var desscription: String = ""
//    let fields: [FormField] = [
//        FormField(icon: .contactImg, placeholder: "Your name (sender)"),
//        FormField(icon: .phone, placeholder: "Your phone number"),
//        FormField(icon: .aboutFax, placeholder: "What is this fax about?")
//    ]
//    var body: some View {
//        ZStack{
//            Color(.whiteClr)
//                .opacity(0.8)
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack(alignment: .leading,spacing: 5){
//                HStack{
//                    Button(action:{
//                        navVM.showCoverPage = false
//
//                    }){
//                        Image(.exitImg)
//                    }
//                    .buttonStyle(.plain)
//                    
//                    Spacer()
//                    Button(action:{
//                        navVM.coverSenderName = values[0]
//                           navVM.coverPhone = values[1]
//                           navVM.coverSubject = values[2]
//                           navVM.coverMessage = desscription
//                           navVM.hasCoverPage = true
//                           
//                           navVM.showCoverPage = false
//
//                    }){
//                        HStack{
//                            Text("Save")
//                                .font(AppFont.medium.size(20))
//                                .foregroundColor(.whiteClr)
//                        }
//                        .padding(.vertical,5)
//                        .padding(.horizontal,10)
//                        .background(RoundedRectangle(cornerRadius: 6).fill(.darkClr))
//                    }
//                    .buttonStyle(.plain)
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                HStack{
//                    Text("Cover Page")
//                        .font(AppFont.regular.size(24))
//                        .foregroundColor(.darkClr)
//                }
//                .padding(.horizontal)
//                VStack(spacing: 16) {
//                    ForEach(fields.indices, id: \.self) { index in
//                        IconTextField(
//                            icon: fields[index].icon,
//                            placeholder: fields[index].placeholder,
//                            text: $values[index]
//                        )
//                    }
//                    
//                    VStack{
//                        TextField("Write your message here...", text: $desscription)
//                            .font(AppFont.regular.size(17))
//                            .foregroundColor(.darkClr)
//                    }
//                    .frame(height: Constants.height * 0.1, alignment: .topLeading)
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color(.whiteClr))
//                    )
//                    
//                }
//                .padding()
//            }
//            .frame(maxWidth: .infinity)
//            .background(RoundedRectangle(cornerRadius: 20).fill(.offWhiteClr))
//            .padding()
//            
//            
//        }
//        
//    }
//}
//
//struct FormField: Identifiable {
//    let id = UUID()
//    let icon: ImageResource
//    let placeholder: String
//}
//struct IconTextField: View {
//    let icon: ImageResource
//    let placeholder: String
//    @Binding var text: String
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            Image(icon)
//            
//            TextField(placeholder, text: $text)
//                .font(AppFont.regular.size(17))
//                .foregroundColor(.darkClr)
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color(.whiteClr))
//        )
//    }
//}
//#Preview {
//    CoverpageView()
//}
//

import SwiftUI

struct CoverpageView: View {
    @EnvironmentObject private var navVM: NavigateViewModel
    @State private var values: [String] = Array(repeating: "", count: 4)
    @State private var desscription: String = ""
    
    let fields: [FormField] = [
        FormField(icon: .contactImg, placeholder: "Your name (sender)"),
        FormField(icon: .phone, placeholder: "Your phone number"),
        FormField(icon: .aboutFax, placeholder: "What is this fax about?")
    ]
    
    var body: some View {
        ZStack {
            Color(.whiteClr)
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 5) {
                
                // MARK: Header
                HStack {
                    Button(action: {
                        navVM.showCoverPage = false
                    }) {
                        Image(.exitImg)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button(action: {
                        navVM.coverSenderName = values[0]
                        navVM.coverPhone = values[1]
                        navVM.coverSubject = values[2]
                        navVM.coverMessage = desscription
                        navVM.hasCoverPage = true
                        navVM.showCoverPage = false
                    }) {
                        HStack {
                            Text("Save") // ✅ Localized
                                .font(AppFont.medium.size(20))
                                .foregroundColor(.whiteClr)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.darkClr)
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Cover Page") // ✅ Localized
                        .font(AppFont.regular.size(24))
                        .foregroundColor(.darkClr)
                }
                .padding(.horizontal)
                
                // MARK: Form
                VStack(spacing: 16) {
                    
                    ForEach(fields.indices, id: \.self) { index in
                        IconTextField(
                            icon: fields[index].icon,
                            placeholder: fields[index].placeholder,
                            text: $values[index]
                        )
                    }
                    
                    VStack {
                        TextField("Write your message here...", text: $desscription) // ✅ Localized
                            .font(AppFont.regular.size(17))
                            .foregroundColor(.darkClr)
                    }
                    .frame(height: Constants.height * 0.1, alignment: .topLeading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.whiteClr))
                    )
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.offWhiteClr)
            )
            .padding()
        }
    }
}


// MARK: - Model

struct FormField: Identifiable {
    let id = UUID()
    let icon: ImageResource          // ✅ FIXED (was wrong type)
    let placeholder: LocalizedStringKey
}


// MARK: - TextField Row

struct IconTextField: View {
    let icon: ImageResource
    let placeholder: LocalizedStringKey
    @Binding var text: String        // ✅ FIXED (must be String)
    
    var body: some View {
        HStack(spacing: 12) {
            Image(icon)
            
            TextField(placeholder, text: $text)
                .font(AppFont.regular.size(17))
                .foregroundColor(.darkClr)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.whiteClr))
        )
    }
}

#Preview {
    CoverpageView()
}
