//
//  DocumentsView.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import SwiftUI


struct DocumentView: View {
    
    @State private var selectedSection: FaxSection = .inbox
    @EnvironmentObject private var navVM: NavigateViewModel

    let messages = [
        Message(number: "+44 7700 900123", date: "Nov 26, 2025 10:12 AM", isNew: true, status: .inbox),
        Message(number: "+44 7700 900123", date: "Nov 26, 2025 10:12 AM", isNew: false, status: .inbox),
        Message(number: "+44 7700 900123", date: "Nov 26, 2025 10:12 AM", isNew: false, status: .inbox),
        Message(number: "+1 202 5550199", date: "Nov 26, 2025 10:12 AM", isNew: true, status: .failed),
        Message(number: "+49 30 11223344", date: "Nov 26, 2025 10:12 AM", isNew: false, status: .sent),
        Message(number: "+1 202 5550199", date: "Nov 26, 2025 10:12 AM", isNew: true, status: .favourite),
        Message(number: "+1 202 5550199", date: "Nov 26, 2025 10:12 AM", isNew: true, status: .favourite),

    ]
    
    var filteredMessages: [Message] {
        switch selectedSection {
        case .inbox:
            return messages.filter { $0.status == .inbox }
        case .sent:
            return messages.filter { $0.status == .sent }
        case .failed:
            return messages.filter { $0.status == .failed }
        case .favourite:
            return messages.filter { $0.status == .favourite }
        }
    }
  
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Documents")
                    .font(AppFont.bold.size(40))
                    .foregroundColor(.darkClr)
                Image(.documentLine)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            DocTop(selected: $selectedSection)
                .padding(.vertical)
            
            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(filteredMessages) { message in
                        MessageRow(message: message)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 0).fill(.whiteClr))

    }
}
enum MessageStatus {
    case inbox
    case sent
    case failed
    case favourite
}

struct Message: Identifiable {
    let id = UUID()
    let number: String
    let date: String
    let isNew: Bool
    let status: MessageStatus
}

struct MessageRow: View {
    @EnvironmentObject private var navVM: NavigateViewModel

    let message: Message
    
    var body: some View {
        HStack(spacing: 10) {
            
            Image(.documentIcon)
            VStack(alignment: .leading, spacing: 3) {
                HStack{
                    Text(message.number)
                        .font(AppFont.regular.size(17))
                        .foregroundColor(.darkClr)
                    Button(action:{
                        
                    }){
                        Image(.copy)
                    }
                }
                Text(message.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if .inbox == message.status {
                    Text(message.isNew ? "New" : "Read")
                        .font(AppFont.regular.size(12))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(RoundedRectangle(cornerRadius: 4).fill(message.isNew ? Color.darkClr : Color.darkClr.opacity(0.3)))
                        .foregroundColor(message.isNew ? .whiteClr : .darkClr)
                }
                else if .failed == message.status {
                    HStack{
                        Text("Failed")
                            .font(AppFont.regular.size(12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(RoundedRectangle(cornerRadius: 4).fill(.redBack))
                            .foregroundColor(.redClr)

                        Button(action:{

                        }){
                            Image(.sharemessage)
                        }
                        .buttonStyle(.plain)
                    }
                }
               else if .sent == message.status {
                    HStack{
                        Text("Delivered")
                            .font(AppFont.regular.size(12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(RoundedRectangle(cornerRadius: 4).fill(.darkClr.opacity(0.3)))    .foregroundColor(.darkClr)
                        Button(action:{
                            
                        }){
                            Image(.sharemessage)
                        }
                        .buttonStyle(.plain)
                    }
                   
                }
                else if .favourite == message.status {
                     HStack{
                         Text("Delivered")
                             .font(AppFont.regular.size(12))
                             .padding(.horizontal, 10)
                             .padding(.vertical, 4)
                             .background(RoundedRectangle(cornerRadius:4).fill(.darkClr.opacity(0.3)))
                            .foregroundColor(.darkClr)
                     } }
                                
                 }
                 Spacer()
            Button(action:{
                navVM.selectedMessage = message
                navVM.showMoreFunctionsView = true
            }){
                Image(.dots)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.offWhiteClr))
        )
        .padding(.vertical, 6)
    }
}

// Documents TopBar

enum FaxSection: LocalizedStringKey, CaseIterable {
    case inbox = "Inbox"
    case sent = "Sent (05)"
    case failed = "Failed (03)"
    case favourite = "Favourite(07)"
    
    var image: ImageResource {
        switch self {
        case .inbox:
            return .inbox
        case .sent:
            return .sent
        case .failed:
            return .failedImg
        case .favourite:
            return .favouriteImg
        }
    }
}

struct DocTop: View {
    
    @Binding var selected: FaxSection
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
        HStack(spacing: 16) {
           
                ForEach(FaxSection.allCases, id: \.self) { section in
                    Button {
                        selected = section
                    } label: {
                        HStack {
                            Image(section.image)
                            Text(section.rawValue)
                                .font(AppFont.medium.size(16))
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 10)
                        .background(
                            selected == section ? Color.darkClr : Color.offWhiteClr
                        )
                        
                        .foregroundColor(
                            selected == section ? .whiteClr : .darkClr
                        )
                        .cornerRadius(14)
                    }
                    .buttonStyle(.plain)
                }
            }

        
        }
    }
}



#Preview {
    DocumentView()
//    DocTop()
}
