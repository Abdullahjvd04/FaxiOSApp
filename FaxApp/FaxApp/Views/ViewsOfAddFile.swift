//
//  CameraView.swift
//  FaxApp
//
//  Created by Ios Dev on 02/03/2026.
//


import SwiftUI
import PhotosUI
import VisionKit
struct CameraView: UIViewControllerRepresentable {
    
    var onImage: (UIImage) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.onImage(image)
            }
            
            picker.dismiss(animated: true)
        }
    }
}





struct CameraPicker: UIViewControllerRepresentable {
    var onCapture: (UIImage) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onCapture: onCapture) }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var onCapture: (UIImage) -> Void
        init(onCapture: @escaping (UIImage) -> Void) { self.onCapture = onCapture }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            picker.dismiss(animated: true)
            if let image = info[.originalImage] as? UIImage {
                onCapture(image)
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct DocumentPickerView: UIViewControllerRepresentable {
    var onPick: (UIImage) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onPick: onPick) }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let types: [UTType] = [.image, .pdf]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: types)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var onPick: (UIImage) -> Void
        init(onPick: @escaping (UIImage) -> Void) { self.onPick = onPick }

        func documentPicker(_ controller: UIDocumentPickerViewController,
                            didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            _ = url.startAccessingSecurityScopedResource()
            defer { url.stopAccessingSecurityScopedResource() }

            if let image = UIImage(contentsOfFile: url.path) {
                onPick(image)
            } else if url.pathExtension.lowercased() == "pdf",
                      let image = renderFirstPDFPage(url: url) {
                onPick(image)
            }
        }

        private func renderFirstPDFPage(url: URL) -> UIImage? {
            guard let doc = CGPDFDocument(url as CFURL),
                  let page = doc.page(at: 1) else { return nil }
            let rect = page.getBoxRect(.mediaBox)
            let renderer = UIGraphicsImageRenderer(size: rect.size)
            return renderer.image { ctx in
                UIColor.white.setFill()
                ctx.fill(rect)
                ctx.cgContext.translateBy(x: 0, y: rect.size.height)
                ctx.cgContext.scaleBy(x: 1, y: -1)
                ctx.cgContext.drawPDFPage(page)
            }
        }
    }
}


struct DocumentScannerView: UIViewControllerRepresentable {
    var onScan: (UIImage) -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onScan: onScan) }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = context.coordinator
        return scanner
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var onScan: (UIImage) -> Void
        init(onScan: @escaping (UIImage) -> Void) { self.onScan = onScan }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController,
                                          didFinishWith scan: VNDocumentCameraScan) {
            controller.dismiss(animated: true)
            if scan.pageCount > 0 {
                onScan(scan.imageOfPage(at: 0))
            }
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            controller.dismiss(animated: true)
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController,
                                          didFailWithError error: Error) {
            controller.dismiss(animated: true)
        }
    }
}


struct AddNoteSheet: View {
    @Binding var noteText: String
    var onDone: (UIImage) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Text("Add Note")
                .font(AppFont.regular.size(17))
                .padding(.top)

            TextEditor(text: $noteText)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                .frame(minHeight: 200)
                .padding(.horizontal)

            Button("Done") {
                let image = renderNoteAsImage(text: noteText)
                dismiss()
                onDone(image)
            }
            .font(AppFont.regular.size(17))
            .foregroundColor(.white)
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.darkClr))

            Spacer()
        }
    }

    private func renderNoteAsImage(text: String) -> UIImage {
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
            (text.isEmpty ? "Empty note" : text).draw(in: rect, withAttributes: attrs)
        }
    }
}
