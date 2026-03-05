//
//  AddFileViewModel.swift
//  FaxApp
//
//  Created by Ios Dev on 02/03/2026.
//

import SwiftUI
import PhotosUI
import VisionKit
import Combine
import UniformTypeIdentifiers

@MainActor
class AddFileViewModel: ObservableObject {
    
    weak var navVM: NavigateViewModel?
    
    @Published var showCamera = false
    @Published var showGallery = false
    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    @Published var showDocumentPicker = false
    @Published var showScanner = false
    @Published var showNoteSheet = false
    let scannerAvailable = VNDocumentCameraViewController.isSupported
    
    @Published var noteText = ""
    func openCamera() {
        showCamera = true
    }
    
    func openGallery() {
        showGallery = true
    }
    
    func openDocumentPicker() {
        showDocumentPicker = true
    }
    
    func openScanner() {
        if scannerAvailable {
            showScanner = true
        }
    }
    
    func openNotes() {
        showNoteSheet = true
    }
        
    func handleSelectedPhoto() async {
        guard let item = selectedPhotoItem else { return }
        
        if let data = try? await item.loadTransferable(type: Data.self),
           let image = UIImage(data: data) {
            openInEditView(image)
        }
    }
    
    func openInEditView(_ image: UIImage) {
        navVM?.currentImage = image
        navVM?.showAddFileView = false
        navVM?.ShowEditView = true
    }
        
    func renderNoteAsImage() -> UIImage {
        let size = CGSize(width: 600, height: 800)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { _ in
            UIColor.white.setFill()
            UIRectFill(CGRect(origin: .zero, size: size))
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 28),
                .foregroundColor: UIColor.black
            ]
            
            let rect = CGRect(x: 40, y: 60, width: size.width - 80, height: size.height - 120)
            (noteText.isEmpty ? "Empty note" : noteText).draw(in: rect, withAttributes: attrs)
        }
    }
}

