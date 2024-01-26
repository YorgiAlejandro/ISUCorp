
import Foundation

public enum LoginStatus : Error {
    case success
    case error
}

//Authorization check
final public class AuthenticationViewModel: ObservableObject {
    @Published public var loginStatus: LoginStatus = .success
    @Published public var didUpdateLoginStatus: Bool = false
    
    public init () {}
    
    public func login (email: String, password: String) {
        if email.lowercased() == "yorgi" && password.lowercased() == "yorgi" {
            loginStatus = .success
        } else {
            loginStatus = .error
        }
        didUpdateLoginStatus = true
    }
    
    func signUp (email: String, password: String) {
        print("registrarse...")
    }
    
    func recoverPassword (email: String) {
        print("Recuperar contraseña...")
    }
}
