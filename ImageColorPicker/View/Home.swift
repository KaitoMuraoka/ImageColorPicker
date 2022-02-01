//
//  Home.swift
//  ImageColorPicker
//
//  Created by 村岡海人 on 2022/02/01.
//

import SwiftUI

struct Home: View {
    @State var showPicker: Bool = false
    @State var selectedColor: Color = .white
    var body: some View {
        ZStack{
            Rectangle()
                .fill(selectedColor)
                .ignoresSafeArea()
            //MARK: -Picker Button
            Button{
                showPicker.toggle()
            }label: {
                Text("Show Image Color Picker")
            }
        }
        //MARK: Calling Modifier
        .imageColorPicker(showPicker: $showPicker, color: $selectedColor)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
