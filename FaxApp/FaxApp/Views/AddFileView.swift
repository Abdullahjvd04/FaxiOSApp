//
//  AddFileView.swift
//  FaxApp
//
//  Created by Ios Dev on 25/02/2026.
//


import SwiftUI
import PhotosUI
import VisionKit



struct AddFileView: View {
    
    @EnvironmentObject private var navVM: NavigateViewModel
    @StateObject private var vm = AddFileViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    navVM.showAddFileView = false
                } label: {
                    Image(.exitImg)
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                Text("Add Files")
                    .font(AppFont.regular.size(24))
                    .foregroundColor(.darkClr)
                    .padding(.top, 30)
                    .padding(.trailing, Constants.width * 0.09)
                
                Spacer()
            }
            
            LazyVStack(spacing: 12) {
                
                AddFileItemsRow(item: AddFileItems(icon: .openCamera, title: "Camera") {
                    vm.openCamera()
                })
                
                AddFileItemsRow(item: AddFileItems(icon: .opengallery, title: "Photos") {
                    vm.openGallery()
                })
                
                AddFileItemsRow(item: AddFileItems(icon: .addFile, title: "Add File") {
                    vm.openDocumentPicker()
                })
                
                AddFileItemsRow(item: AddFileItems(icon: .scan, title: "Scan") {
                    vm.openScanner()
                })
                
                AddFileItemsRow(item: AddFileItems(icon: .addNote, title: "Add Notes") {
                    vm.openNotes()
                })
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 20).fill(.offWhiteClr))
        
        .onAppear {
            vm.navVM = navVM
        }
        
        .fullScreenCover(isPresented: $vm.showCamera) {
            CameraPicker { image in
                vm.openInEditView(image)
            }
            .ignoresSafeArea()
        }
        
        .photosPicker(
            isPresented: $vm.showGallery,
            selection: $vm.selectedPhotoItem,
            matching: .images
        )
        .onChange(of: vm.selectedPhotoItem) { _ in
            Task { await vm.handleSelectedPhoto() }
        }
        
        .sheet(isPresented: $vm.showDocumentPicker) {
            DocumentPickerView { image in
                vm.openInEditView(image)
            }
        }
        .fullScreenCover(isPresented: $vm.showScanner) {
            DocumentScannerView { image in
                vm.openInEditView(image)
            }
            .ignoresSafeArea()
        }
                .sheet(isPresented: $vm.showNoteSheet) {
            AddNoteSheet(noteText: $vm.noteText) {_ in 
                let image = vm.renderNoteAsImage()
                vm.openInEditView(image)
            }
        }
    }
}


struct AddFileItems: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let title: LocalizedStringKey
    let action: () -> Void
}
struct AddFileItemsRow: View {
    var item: AddFileItems
    
    var body: some View {
        Button(action: {
            item.action()
        }) {
            HStack(spacing: 10) {
                
                Image(item.icon)
                HStack{
                    Text(item.title)
                }
                    .foregroundColor(.darkClr)
                    .font(AppFont.regular.size(17))
                    .frame(width: 90,alignment: .leading)

            }
            .padding()
            
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.whiteClr)
            )
        }
        .buttonStyle(.plain)
    }
    
}
