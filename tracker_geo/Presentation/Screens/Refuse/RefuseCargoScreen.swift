//
//  RefuseCargoScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 6.11.23.
//

import SwiftUI

struct RefuseCargoScreen: View {
    @State private var selection = "Red"
    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
    @State var address = ""
    @State var doesClose = false
    var body: some View {
        VStack(alignment: .leading)
        {
            Text("Оформить отказ")
                .font(.title3)
                .bold()
                .padding(.horizontal,15)
                .padding(.top,30)
            
            CustomDropDown()
                .padding(.horizontal,15)
            TextField("Примечание (необязательно)", text: $address, axis: .vertical)
                .lineLimit(5...7)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1)
                ).padding()
            Text("Не мение 20 символов")
                .font(.caption)
                .padding(.horizontal,15)
            if #available(iOS 17.0, *){
                Toggle("Отказ по нашей вине", isOn: $doesClose)
                    .toggleStyle(CheckboxStyle())
                    .padding(.all,15)
            }
            
            Spacer()
            if #available(iOS 17.0, *) {
                AnimatedButton(
                    content: {
                        HStack{
                            Spacer()
                            Text("Оформить отказ")
                            Spacer()
                        }
                        .foregroundColor(.white)
                    },
                    action: {
                        return .success
                    }, buttonTint: Color(hex: 0xffF44336)
                )
                .padding(.horizontal, 15)
                .padding(.bottom,7)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    RefuseCargoScreen()
}


struct CustomDropDown: View {
    @State private var selectedOption = "Причина отказа"
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        Menu {
            Picker("Options", selection: $selectedOption) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(.inline)
        } label: {
            HStack {
                Text(selectedOption)
                Spacer()
                Image(systemName: "chevron.down")
            }
            .foregroundColor(.gray)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.gray, lineWidth: 1)
            )
        }
    }
}


@available(iOS 17.0, *)
struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .symbolEffect(.bounce, value: configuration.isOn)
                .font(.system(size: 20, weight: .regular, design: .default))
            configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }
        
    }
}
