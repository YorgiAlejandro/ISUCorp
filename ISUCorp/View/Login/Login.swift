//
//  Login.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/22/24.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var isLoggedIn: IsLoggedIn
    @State var user: String = ""
    @State var password: String = ""
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @State var messageLogin: String = ""
    
    var body: some View {
        ScrollView {
            //Login Image
            Image("LoginImage")
                .resizable()
                .scaledToFit()
                .frame(height: 190)
            //User input
            HStack {
                Image(systemName: "person")
                    .padding(15)
                    .foregroundColor(.gray.opacity(0.7))
                    .scaledToFit()
                    .frame(height: 70)
                TextField("Your name", text: $user)
                    .textFieldStyle(.plain)
                    .foregroundColor(.gray.opacity(0.6))
            }
            .font(.title2)
            .frame(width: 350, height: 50)
            .padding(15)
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.green.opacity(0.5), lineWidth: 2))
            //Password input
            HStack {
                Image(systemName: "lock")
                    .padding(15)
                    .foregroundColor(.gray.opacity(0.7))
                    .scaledToFit()
                    .frame(height: 70)
                SecureField("Your password", text: $password)
                    .textFieldStyle(.plain)
                    .foregroundColor(.gray.opacity(0.6))
            }
            .font(.title2)
            .frame(width: 350, height: 50)
            .padding(15)
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.green.opacity(0.5), lineWidth: 2))
            .padding(.top, 10)
            //Button Login
            Button("Login"){
                authenticationViewModel.login(email: user, password: password)
                if authenticationViewModel.loginStatus == .success {
                    messageLogin = "Successfully authenticated"
                    isLoggedIn.isLoggedIn = true
                }else{ messageLogin = "Incorrect credentials" }
            }
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .frame(width: 380, height: 70)
            .background(Color.green)
            .cornerRadius(10)
            .padding(.top, 10)
            //Forgot?
            Link(destination: URL(string: "https://yorgisoftcompany.vercel.app")!) {
                Text("Forgot?")
                    .frame(width: 380, height: 30, alignment: .trailing)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            //auth information
            Text(messageLogin)
                .foregroundColor(authenticationViewModel.loginStatus == .success ? .green : .red)
                .font(.title2)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
