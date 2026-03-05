//
//  EditView.swift
//  FaxApp
//
//  Created by Ios Dev on 26/02/2026.
//
//


import SwiftUI
import TOCropViewController

struct EditView: View {
    
    @EnvironmentObject private var navVM: NavigateViewModel
    @StateObject private var vm = EditViewModel()
    @State private var selectedItemID: UUID? = nil
    @State private var dragOffset: CGSize = .zero
    
    private var imageFrameWidth: CGFloat  { Constants.width * 0.85 }
    private var imageFrameHeight: CGFloat { Constants.height * 0.6 }
    
    @State private var showCropper = false
    var editButtonItems: [EditButtonItem] { [
        EditButtonItem(icon: .crop) {
            vm.showBorderColors = false
            showCropper = true
        },
        EditButtonItem(icon: .rotate) {
            
            if let rotated = vm.rotateImage(currentImage: navVM.currentImage) {
                navVM.currentImage = rotated
            }
        },
        EditButtonItem(icon: .border) {
            vm.showBorderColors = true
        },
        EditButtonItem(icon: .signautre) {
            vm.showBorderColors = false
            navVM.showSignatureView = true

        }
    ]}
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    navVM.ShowEditView = false
                } label: {
                    Image(.bkBtn)
                }
                Spacer()
                
                Button {
                    applyEditsAndClose()
                } label: {
                    Text("Done")
                        .font(AppFont.semiBold.size(16))
                        .foregroundColor(.whiteClr)
                        .padding(6)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.darkClr)
                        )
                }
            }
            
            ZStack {
                
                Image(uiImage: vm.displayedImage ?? navVM.currentImage)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color(vm.borderColor), lineWidth: vm.borderWidth)
                    )
                
                if let sig = navVM.signatureImage {
                    Image(uiImage: sig)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageFrameWidth * 0.5)
                        .offset(
                            x: vm.signaturePosition.width + dragOffset.width,
                            y: vm.signaturePosition.height + dragOffset.height
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { dragOffset = $0.translation }
                                .onEnded {
                                    vm.signaturePosition.width += $0.translation.width
                                    vm.signaturePosition.height += $0.translation.height
                                    dragOffset = .zero
                        }
                        )
                    
                }
            }
            .frame(width: imageFrameWidth, height: imageFrameHeight)
            .background(Color.offWhiteClr.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
            Spacer()
            if vm.showBorderColors {
                HStack{
                    BorderColorsView(vm: vm)
                }
                .frame(width: Constants.width * 0.8, height: Constants.width * 0.05)
                .padding(.bottom,30)
            }
            HStack(spacing: 16) {
                ForEach(editButtonItems) { item in
                    EditBottomButtons(
                        item: item,
                        isSelected: selectedItemID == item.id
                    ) {
                        selectedItemID = item.id
                        item.action()
                    }
                }
            }
            .padding(.top, 12)
        }
        .padding()
        .background(Color.whiteClr)
        .sheet(isPresented: $navVM.showSignatureView) {
            AddSignatureView()
                .environmentObject(navVM)
                .presentationDetents([.fraction(0.7)])
        }
        .sheet(isPresented: $showCropper) {
            ImageCropperView(
                image: vm.displayedImage ?? navVM.currentImage,
                croppingStyle: .default,
                onCrop: { croppedImage in
                    vm.displayedImage = croppedImage
                    navVM.currentImage = croppedImage
                    showCropper = false
                },
                onCancel: {
                    showCropper = false
                }
            )
            .presentationBackground(Color.offWhiteClr)
        }
        .background(Color(.offWhiteClr))
        .onAppear {
            vm.setInitialImage(navVM.currentImage)
        }
    }
    
    private func applyEditsAndClose() {
        var finalImage = vm.displayedImage ?? navVM.currentImage
        
        if let sig = navVM.signatureImage {
            if let result = vm.flattenSignature(
                baseImage: finalImage,
                signature: sig,
                position: vm.signaturePosition,
                frameWidth: imageFrameWidth,
                frameHeight: imageFrameHeight
            ) {
                finalImage = result
            }
        }
        
        if let bordered = vm.flattenBorder(on: finalImage) {
            finalImage = bordered
        }
        
        navVM.currentImage = finalImage
        navVM.faxDocuments.append(finalImage) 
        navVM.ShowEditView = false
    }
}
struct EditButtonItem: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let action: () -> Void
}

struct EditBottomButtons: View {
    let item: EditButtonItem
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: {
            onSelect()
            item.action()
        }) {
            HStack {
                Spacer()
                Image(item.icon)
                    .foregroundColor(isSelected ? .whiteClr : .darkClr)
                    .background(
                        Circle()
                            .fill(isSelected ? .darkClr : .offWhiteClr)
                            .frame(width: 60, height: 60)
                    )
                Spacer()
            }
        }
    }
}

#Preview {
    EditView()
        .environmentObject(NavigateViewModel())
}




