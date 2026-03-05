////
////  BorderColorsView.swift
////  FaxApp
////
////  Created by Ios Dev on 26/02/2026.
////


import SwiftUI

struct BorderColorsView: View {
    
    @ObservedObject var vm: EditViewModel
    @State private var selectedItemID: UUID? = nil
    
    var bordercolors: [ColorI] = [
        ColorI(icon: .notselect, colorName: nil),
        ColorI(icon: .borderdarkclr, colorName: "borderdarkclr"),
        ColorI(icon: .borderblack, colorName: "borderblack"),
        ColorI(icon: .borderb2, colorName: "borderb2"),
        ColorI(icon: .borderdarkgray, colorName: "borderdarkgray"),
        ColorI(icon: .borderblacklightgrey, colorName: "borderblacklightgrey"),
        ColorI(icon: .borderoffwhite, colorName: "borderoffwhite")
    ]
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(bordercolors) { item in
                ColorItems(
                    item: item,
                    isSelected: selectedItemID == item.id
                ) {
                    selectedItemID = item.id
                    
                    if let name = item.colorName {
                        vm.borderColor = UIColor(named: name) ?? .clear
                    } else {
                        vm.borderColor = .clear
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).fill(.offWhiteClr))
    }
}

struct ColorI: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let colorName: String?
}

struct ColorItems: View {
    let item: ColorI
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            Image(item.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2)
                )
        }
        .frame(maxWidth: .infinity)
    }
}
//#Preview {
//    BorderColorsView()
//}
