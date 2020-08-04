//
//  ImagePickerView.swift
//  Elenco
//
//  Created by James Bernhardt on 04/08/2020.
//  Copyright © 2020 Elenco. All rights reserved.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
