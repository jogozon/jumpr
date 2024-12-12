import SwiftUI
import FirebaseFirestore
import UIKit
import PhotosUI

struct AddGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var gameViewModel = GameViewModel()
    
    var user: UserModel
    var userVM: UserViewModel
    
    // Form fields
    @State private var gameName = ""
    @State private var size = 1
    @State private var userTeamScore: Int = 0
    @State private var opponentTeamScore: Int = 0
    @State private var notes = ""
    @State private var location = ""
    @State private var date: Date = Date()
    
    // Validation and error states
    @State private var showMessage = false
    @State private var errorMessage = ""
    
    // photo states
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Photo Picker
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label("Choose a Photo", systemImage: "photo.fill")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                // Display Selected Image
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                        .padding()
                }
                
                Form {
                    Section(header: Text("Game Details")) {
                        CustomTextField(text: $gameName)
                            .autocapitalization(.words)
                        
                        Stepper("\(size) v \(size)", value: $size, in: 1...5)
                        
                        TextField("Location (Optional)", text: $location)
                        
                        TextField("Notes (Optional)", text: $notes)
                        
                        DatePicker("Date picker", selection: $date)
                    }
                    
                    Section(header: Text("Score")) {
                        VStack(spacing: 10) {
                            HStack {
                                VStack {
                                    Text("Your Team")
                                        .font(.headline)
                                    
                                    Picker("Your Team Score", selection: $userTeamScore) {
                                        ForEach(0..<101) { score in
                                            Text("\(score)").tag(score)
                                        }
                                    }
                                    .pickerStyle(WheelPickerStyle())
                                    .frame(height: 100)
                                }
                                
                                VStack {
                                    Text("Opponent Team")
                                        .font(.headline)
                                    
                                    Picker("Opponent Team Score", selection: $opponentTeamScore) {
                                        ForEach(0..<101) { score in
                                            Text("\(score)").tag(score)
                                        }
                                    }
                                    .pickerStyle(WheelPickerStyle())
                                    .frame(height: 100)
                                }
                            }
                        }
                        
                        Section {
                            Button(action: {
                                gameViewModel.addGame(userId: user.uid ?? "", gameName: gameName, size: size, score: [userTeamScore, opponentTeamScore], notes: notes)
                                
                                gameName = ""
                                size = 1
                                userTeamScore = 0
                                opponentTeamScore = 0
                                notes = ""
                                location = ""
                                date = Date()
                                showMessage = true
                            }, label: {
                                Text("Save Game")
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            })
                            .disabled(gameName.isEmpty)
                        }
                    }
                    .navigationTitle("Add New Game")
                    .alert(isPresented: $showMessage) {
                        Alert(
                            title: Text("Game logged!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Load the selected image
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}


struct CustomTextField : UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Game Name",
            attributes: [
                .foregroundColor: UIColor.systemOrange
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


//#Preview {
//    AddGameView(user: UserModel(
//        uid: "a1b2c3d4e5",
//        firstName: "John",
//        lastName: "Doe",
//        displayName: "JohnD",
//        email: "johndoe@example.com",
//        profileUrl: "https://example.com/profiles/johndoe",
//        courtLocations: ["Central Park Court", "Downtown Court"],
//        games: ["Basketball", "Tennis", "Soccer"]
//    ), userVM: UserViewModel())
//
//}
