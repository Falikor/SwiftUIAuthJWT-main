//
//  PdfView.swift
//  SwiftClient
//
//  Created by 19494115 on 09.05.2022.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct ActivityViewController: UIViewControllerRepresentable {

 var itemsToShare: [Any]
 var servicesToShareItem: [UIActivity]? = nil

 func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
 let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: servicesToShareItem)
 return controller
 }

 func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
