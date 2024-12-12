//
//  CustomTextField.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/11/24.
//

import Foundation
import SwiftUI
import UIKit

struct MyTextField : UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.attributedPlaceholder = NSAttributedString(
                   string: "UIKit Name",
                   attributes: [
                    .foregroundColor: UIColor.systemTeal
                   ]
               )

        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>){
            self._text = text
        }

        // TextField will invoke this method every single time the user has change characters in the textfield
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
