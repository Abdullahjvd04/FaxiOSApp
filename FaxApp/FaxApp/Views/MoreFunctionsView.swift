//
//  MoreFunctionsView.swift
//  FaxApp
//
//  Created by Ios Dev on 25/02/2026.
//

import SwiftUI

struct MoreFunctionsView: View {
    @EnvironmentObject private var navVM: NavigateViewModel
    
    var more: [MoreItems] {
        var items: [MoreItems] = [
            MoreItems(icon: .viewImg, title: "View") {navVM.showMoreFunctionsView = false}
        ]
        
        if navVM.selectedMessage?.status != .failed {
            items.append(
                MoreItems(icon: .share, title: "Share") {navVM.showMoreFunctionsView = false}
            )
        }
        
        if navVM.selectedMessage?.status == .failed {
            items.append(
                MoreItems(icon: .resend, title: "Resend") {navVM.showMoreFunctionsView = false}
            )
        }
        
        items.append(contentsOf: [
            MoreItems(icon: .fav, title: "Add / Remove") {navVM.showMoreFunctionsView = false},
            MoreItems(icon: .dlt, title: "Delete") {navVM.showMoreFunctionsView = false}
        ])
        
        return items
    }
    
    var body: some View {
        ZStack(alignment: .trailing){
            Color(.whiteClr).opacity(0.1)

            VStack(alignment:.leading, spacing: 10){
                ForEach(more){ item in
                    MoreItemsRow(item: item)
                }
            }
            .padding(.vertical,10)
            .frame(width: Constants.width * 0.5,alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 7).fill(.offWhiteClr))
            .padding(.horizontal)
        }
    }
}


struct MoreItems: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let title: LocalizedStringKey
    let action: () -> Void
}
struct MoreItemsRow: View {
    var item: MoreItems
    
    var body: some View {
        
        Button(action: {
            item.action()
        }) {
            HStack(spacing: 10) {
             
                Image(item.icon)
                Text(item.title)
                
                    .foregroundColor(.darkClr)
                    .font(AppFont.regular.size(17))

            }
            .padding(.horizontal)
            
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.offWhiteClr)
            )
        }
        .buttonStyle(.plain)
    }
}
#Preview {
    MoreFunctionsView()
}
