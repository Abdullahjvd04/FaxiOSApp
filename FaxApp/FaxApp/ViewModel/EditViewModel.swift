//
//  EditViewModel.swift
//  FaxApp
//
//  Created by Ios Dev on 02/03/2026.
//



import SwiftUI
import Combine

class EditViewModel: ObservableObject {

    @Published var displayedImage: UIImage?
    @Published var rotationDegrees: CGFloat = 0
    @Published var signaturePosition: CGSize = .zero
    @Published var showBorderColors: Bool = false
    @Published var borderColor: UIColor = .clear
    @Published var borderWidth: CGFloat = 16
    func setInitialImage(_ image: UIImage) {
        displayedImage = image
    }
    
    func rotateImage(currentImage: UIImage) -> UIImage? {
        rotationDegrees = (rotationDegrees + 90).truncatingRemainder(dividingBy: 360)
        guard let rotated = applyRotation(to: currentImage, degrees: rotationDegrees) else { return nil }
        displayedImage = rotated
        return rotated
    }
    
    private func applyRotation(to image: UIImage, degrees: CGFloat) -> UIImage? {
        let radians = degrees * .pi / 180
        
        let newSize: CGSize =
        (degrees == 90 || degrees == 270)
        ? CGSize(width: image.size.height, height: image.size.width)
        : image.size
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        context.rotate(by: radians)
        
        image.draw(in: CGRect(
            x: -image.size.width / 2,
            y: -image.size.height / 2,
            width: image.size.width,
            height: image.size.height
        ))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func flattenSignature(
        baseImage: UIImage,
        signature: UIImage,
        position: CGSize,
        frameWidth: CGFloat,
        frameHeight: CGFloat
    ) -> UIImage? {
        
        let sigDisplayWidth = frameWidth * 0.5
        let sigDisplayHeight = sigDisplayWidth * (signature.size.height / signature.size.width)
        
        let scaleX = baseImage.size.width / frameWidth
        let scaleY = baseImage.size.height / frameHeight
        
        let centerX = frameWidth / 2 + position.width
        let centerY = frameHeight / 2 + position.height
        
        let sigRect = CGRect(
            x: (centerX - sigDisplayWidth / 2) * scaleX,
            y: (centerY - sigDisplayHeight / 2) * scaleY,
            width: sigDisplayWidth * scaleX,
            height: sigDisplayHeight * scaleY
        )
        
        UIGraphicsBeginImageContextWithOptions(baseImage.size, false, baseImage.scale)
        defer { UIGraphicsEndImageContext() }
        
        baseImage.draw(in: CGRect(origin: .zero, size: baseImage.size))
        signature.draw(in: sigRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func flattenBorder(on image: UIImage) -> UIImage? {
        guard borderColor != .clear else { return image }
        
        let rect = CGRect(origin: .zero, size: image.size)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        
        image.draw(in: rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return image }
        
        let scaledWidth = borderWidth * (image.size.width / 300)
        context.setStrokeColor(borderColor.cgColor)
        context.setLineWidth(scaledWidth)
        context.stroke(rect.insetBy(dx: scaledWidth/2, dy: scaledWidth/2))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
