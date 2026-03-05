//
//  NavigateViewModel.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import Foundation
import Combine
internal import CoreGraphics
import UIKit

enum Screen {
    case splash
    case home
    case document
    case setting
}


final class NavigateViewModel: ObservableObject {
    
    @Published var showAddFileView: Bool = false
    @Published var ShowEditView: Bool = false
    @Published var currentImage: UIImage = UIImage()
    @Published var signatureImage: UIImage? = nil
    @Published var showSignatureView: Bool = false
    @Published var showAddNoteView: Bool = false
    @Published var noteText: String = ""
    @Published var currentScreen: Screen = .splash
    @Published var showProView: Bool = false
    @Published var showCoverPage: Bool = false
    @Published var showImagePreviewView: Bool = false
    @Published var showMoreFunctionsView: Bool = false
    @Published var selectedMessage: Message?
    @Published var showDocumentView : Bool = false
    @Published var showCamera = false
    @Published var showPhotoPicker = false
    @Published var showDocumentPicker = false
    @Published var showScanner = false
    @Published var coverSenderName: String = ""
    @Published var coverPhone: String = ""
    @Published var coverSubject: String = ""
    @Published var coverMessage: String = ""
    @Published var hasCoverPage: Bool = false
    @Published var faxDocuments: [UIImage] = []
    

}
