//
//  HomeView.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//


import SwiftUI
import ContactsUI
struct Constants {
    static let width: CGFloat = UIScreen.main.bounds.width
    static let height: CGFloat = UIScreen.main.bounds.height
}

struct HomeView: View {
    @State private var recipientNumber: String = ""
    @EnvironmentObject var navVM: NavigateViewModel
    @State private var isShowItems = false
    @State private var showContactPicker = false
    var body: some View {

        VStack {
            HStack {
                VStack(spacing: 0) {
                    Text("New Fax")
                        .font(AppFont.bold.size(40))
                        .foregroundColor(.darkClr)
                    Image(.settingLines)
                }

                Spacer()

                Button(action: {
                    navVM.showProView = true
                }) {
                    Image(.proBtn)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("Choose Recipient")
                .font(AppFont.regular.size(20))
                .foregroundColor(.blackClr)
                .frame(maxWidth: .infinity, alignment: .leading)

            ZStack {
                Image(.phoenRecipient)
                HStack(spacing: 10) {
                    Image(.uSflag)
                    Text("+1")
                        .font(AppFont.regular.size(20))
                    Rectangle()
                        .frame(width: 1, height: 50)
                        .foregroundColor(.darkClr)
                    TextField("Enter the recipient's number", text: $recipientNumber)
                        .keyboardType(.phonePad)
                        .font(AppFont.regular.size(14))
                    Spacer()
                    Button {
                        showContactPicker = true
                    } label: {
                        Image(.contact)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }

         
            if navVM.hasCoverPage || !navVM.faxDocuments.isEmpty {

                if navVM.hasCoverPage {

            Button(action: {
             navVM.showCoverPage = true
               }) {
              ZStack {
            Image(.coverPage)

              HStack (spacing: 10){
                  Image(.documentSelect)
                  VStack(alignment: .leading, spacing: 5) {
                   if navVM.hasCoverPage {
                    Text(navVM.coverSubject.isEmpty ? "Fax Mail" : navVM.coverSubject)
                    .font(AppFont.regular.size(20))
//                    Text("Sender: \(navVM.coverSenderName.isEmpty ? "Unknown" : navVM.coverSenderName)")
                       Text("Sender: ") +
                       Text(navVM.coverSenderName.isEmpty ? "Unknown" : navVM.coverSenderName)
                    .font(AppFont.regular.size(14))
                    }
                    else {
                    Text("Fax Mail")
                    .font(AppFont.regular.size(20))
                    .opacity(0.6)
                    Text("Sender: Your Name")
                    .font(AppFont.regular.size(14))
                    .opacity(0.6)
                    }
                    }
                    .foregroundColor(.darkClr)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                  if navVM.hasCoverPage {
                    Button(action: {
                    navVM.hasCoverPage = false
                    navVM.coverSubject = ""
                    navVM.coverSenderName = ""
                    }) {
                    Image(.dltIcon)
                    }
                    }
                }
                            .padding(.horizontal)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }

                if !navVM.faxDocuments.isEmpty {
                    ScrollView {
                        VStack {
                            ForEach(Array(navVM.faxDocuments.enumerated()), id: \.offset) { index, image in
                                HStack(spacing: 10) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 60)
                                        .cornerRadius(6)

                                    VStack(alignment:.leading,spacing: 5) {
                                        Text("Document") + Text(" \(index + 1)")
                                            .font(AppFont.regular.size(20))
                                        Text("1 page (JPG file)")
                                            .font(AppFont.regular.size(14))
                                    }
                                    .foregroundColor(.darkClr)

                                    Spacer()

                                    Button {
                                        navVM.faxDocuments.remove(at: index)
                                    } label: {
                                        Image(.dltIcon)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 13)
                                        .fill(.offWhiteClr)
                                )
                            }
                            Spacer()

                            Button(action: {
                                navVM.showAddFileView = true
                            }) {
                                VStack(spacing: 10) {
                                    Image(.addDocuments)
                                    Text("Add Documents")
                                        .font(AppFont.medium.size(24))
                                        .foregroundColor(.darkClr)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .frame(height: Constants.height * 0.2)
                                .background(RoundedRectangle(cornerRadius: 13).fill(.offWhiteClr))
                            }
                            .buttonStyle(.plain)
                        }
                    
                    }
                    .frame(height: Constants.height * 0.28)

                }


            } else {

                Button(action: {
                    navVM.showCoverPage = true
                }) {
                    ZStack {
                        Image(.coverPage)
                        HStack {
                            Image(.documentSelect)
                            VStack(spacing: 0) {
                                Text("Add cover page ( Optional)")
                                    .font(AppFont.regular.size(20))
                                Text("Include your name and contact details")
                                    .font(AppFont.regular.size(14))
                            }
                            .foregroundColor(.darkClr)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                Text("Choose Documents")
                    .font(AppFont.regular.size(20))
                    .foregroundColor(.blackClr)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: {
                    navVM.showAddFileView = true
                }) {
                    VStack(spacing: 10) {
                        Image(.addDocuments)
                        Text("Add Documents")
                            .font(AppFont.medium.size(24))
                            .foregroundColor(.darkClr)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .frame(height: Constants.height * 0.2)
                    .background(RoundedRectangle(cornerRadius: 13).fill(.offWhiteClr))
                }
                .buttonStyle(.plain)
            }


            Button(action: {
            }) {
                ZStack {
                    Image(.faxNowBtn)
                    Text("Fax Now")
                        .font(AppFont.medium.size(26))
                        .foregroundColor(.whiteClr)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .overlay() {
            Button {
                isShowItems.toggle()
                navVM.showAddFileView = true
            } label: {
                Image(isShowItems ? .eye : .addBtn)
                    .clipped()
            }
            .padding(.bottom, Constants.height * 0.28)
        }
        .sheet(isPresented: $navVM.showAddFileView) {
            AddFileView()
                .environmentObject(navVM)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7)])
        }
        .sheet(isPresented: $showContactPicker) {
            ContactPicker { selectedNumber in
                
                let cleaned = selectedNumber
                    .replacingOccurrences(of: " ", with: "")
                    .replacingOccurrences(of: "-", with: "")
                    .replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                
                recipientNumber = cleaned
            }
        }
        .onChange(of: navVM.faxDocuments) { newValue in
            
            if !newValue.isEmpty && !navVM.hasCoverPage {
                
                navVM.hasCoverPage = true
                
                if navVM.coverSubject.isEmpty {
                    navVM.coverSubject = "Fax Mail"
                }
                
                if navVM.coverSenderName.isEmpty {
                    navVM.coverSenderName = "Your Name"
                }
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
