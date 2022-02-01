//
//  CustomColorPicker.swift
//  ImageColorPicker
//
//  Created by 村岡海人 on 2022/02/01.
//

import SwiftUI

//MARK: -Making extension to cell Image Color Picker
extension View{
    func imageColorPicker(showPicker: Binding<Bool>, color: Binding<Color>) -> some View{
        return self
        //Full Sheet
            .fullScreenCover(isPresented: showPicker) {
            } content: {
                Helper(showPicker: showPicker, color: color)
            }

    }
}

//MARK: Custom View for Color Picker
struct Helper: View {
    @Binding var showPicker: Bool
    @Binding var color: Color
    var body: some View{
        NavigationView{
            VStack(spacing: 10){
                //Since we need only Live picker
                CustomColorPicker(color: $color)
                    .frame(width: 100, height: 50, alignment: .topLeading)
                    .clipped()
                    .offset(x: 20)
            }
            .navigationTitle("Image Color Picker")
            .navigationBarTitleDisplayMode(.inline)
            //Close Button
            .toolbar {
                Button("Close"){
                    showPicker.toggle()
                }
            }
        }
    }
}


//MARK: -Custom Color Picker with the Help of UIColorPicker
struct CustomColorPicker: UIViewControllerRepresentable{
    
    //MARK: Picker Values
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        
        //Connectiong Delegate
        picker.delegate = context.coordinator
        picker.title = ""
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
    }
    
    //MARK -Make Delegate Methods
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            //Updating Color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
}
