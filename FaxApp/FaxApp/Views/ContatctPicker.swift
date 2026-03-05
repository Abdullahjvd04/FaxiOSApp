//
//  ContatctPicker.swift
//  FaxApp
//
//  Created by Ios Dev on 04/03/2026.
//


import SwiftUI
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {

    var onSelect: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect)
    }

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    class Coordinator: NSObject, CNContactPickerDelegate {

        var onSelect: (String) -> Void

        init(onSelect: @escaping (String) -> Void) {
            self.onSelect = onSelect
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {

            if let number = contact.phoneNumbers.first?.value.stringValue {
                onSelect(number)
            }
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {

            if let number = contactProperty.value as? CNPhoneNumber {
                onSelect(number.stringValue)
            }
        }
    }
}
