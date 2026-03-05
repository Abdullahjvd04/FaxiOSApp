//
//  ImageCropperView.swift
//  FaxApp
//
//  Created by Ios Dev on 04/03/2026.
//

import SwiftUI
import TOCropViewController

struct ImageCropperView: UIViewControllerRepresentable {
    
    var image: UIImage
    var croppingStyle: TOCropViewCroppingStyle = .default
    var onCrop: (UIImage) -> Void
    var onCancel: () -> Void

    func makeUIViewController(context: Context) -> TOCropViewController {
        let cropVC = TOCropViewController(croppingStyle: croppingStyle, image: image)
        cropVC.delegate = context.coordinator
        
        cropVC.rotateButtonsHidden = true
        cropVC.rotateClockwiseButtonHidden = true
        
        cropVC.doneButtonColor = UIColor.darkClr
        cropVC.cancelButtonColor = UIColor.offWhiteClr
        cropVC.view.backgroundColor = .clear
           cropVC.cropView.backgroundColor = .clear
        return cropVC
    }
    
    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, TOCropViewControllerDelegate {
        let parent: ImageCropperView
        
        init(_ parent: ImageCropperView) {
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: TOCropViewController,
                                didCropTo image: UIImage,
                                with cropRect: CGRect,
                                angle: Int) {
            parent.onCrop(image)
        }
        
        func cropViewController(_ cropViewController: TOCropViewController,
                                didFinishCancelled cancelled: Bool) {
            parent.onCancel()
        }
    }
}
