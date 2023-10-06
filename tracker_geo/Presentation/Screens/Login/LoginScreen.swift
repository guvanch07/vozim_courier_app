//
//  LoginScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 1.08.23.
//

import SwiftUI
import InputMask

struct LoginScreen: View {
    @EnvironmentObject var vm: LoginViewModel
    enum Field {
            case phoneField
            case passwordField
        }
    @State private var phoneField = ""
    @State private var passwordField = ""
    @State var phone = ""
    @State var phoneComplete = false
    @FocusState private var focusedPhoneField: Field?
    @FocusState private var focusedPasswordField: Field?
    
        
    var body: some View {
        VStack(spacing: 30){
                Spacer().frame(height: 50)
                Text("Войти")
                    .fontWeight(.medium)
                    .font(.system(size: 24))
                
                InputMask.MaskedTextField(
                    text: $phone,
                    value: $phoneField,
                    complete: $phoneComplete,
                    placeholder: "+375(00)000-00-00",
                    primaryMaskFormat:  "+375([00])[000]-[00]-[00]"
                )
                .monospaced()
                .keyboardType(.phonePad)
                .returnKeyType(.done)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(focusedPhoneField != nil ? Color(hex: 0xFFFFA45B) : .gray, lineWidth: 1)
            )
            .keyboardType(.phonePad)
            .focused($focusedPhoneField, equals: .phoneField)
            .textContentType(.familyName)
            .submitLabel(.next)
            
            TextField(
                "password",
                text: $passwordField
            )
            .onSubmit {
                hideKeyboard()
            }
            .focused($focusedPasswordField, equals: .passwordField)
            .textContentType(.emailAddress)
            .submitLabel(.done)
            .textFieldStyle(BorderedStyle(focused: focusedPasswordField != nil))
            
            Button {
                vm.login(phone: phone, password: passwordField)
                hideKeyboard()
            } label: {
                HStack{
                    Spacer()
                    if vm.isRefreshing{
                        ProgressView()
                    }else{
                        Text("Начать")
                    }
                    Spacer()
                }
            }
            .disabled(vm.isRefreshing)
            .padding([.vertical], 10)
            .foregroundColor(.black)
            .background(appAccentColor)
            .cornerRadius(24)
            
            Spacer()
        }
        .padding(24)
        .contentShape(Rectangle())
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("OK") {
               
            }
        }
        .onTapGesture {
            print("tap")
            hideKeyboard()
            
        }
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct BorderedStyle: TextFieldStyle {
  var focused: Bool

  func _body(configuration: TextField<Self._Label>) -> some View {
      configuration
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(focused ? Color(hex: 0xFFFFA45B) : .gray, lineWidth: 1)
          )
  }}
