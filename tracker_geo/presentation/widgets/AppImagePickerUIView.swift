//
//  AppImagePickerUIView.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 29.07.23.
//

import SwiftUI
import PhotosUI

struct AppImagePickerUIView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State var images: [UIImage] = []
    var body: some View {
        ForEach(images, id:\.cgImage){ image in
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
        }
        
        PhotosPicker(
            selection: $selectedItems,
            matching: .images,
            photoLibrary: .shared()) {
                Text("Select a photo")
            }
            .onChange(of: selectedItems) { selectedItems in
                Task {
                    images = []
                    for item in selectedItems {
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let imageData):
                                if let imageData {
                                    self.images.append(UIImage(data: imageData)!)
                                } else {
                                    print("No supported content type found.")
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                }
            }
    }
}

struct AppImagePickerUIView_Previews: PreviewProvider {
    static var previews: some View {
        AppImagePickerUIView()
    }
}
