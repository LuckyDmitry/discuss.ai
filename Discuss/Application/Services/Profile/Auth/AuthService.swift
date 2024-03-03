import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import UIKit

struct UserData: Codable {
  
}

protocol HasAuthService {
  var authService: IAuthService { get }
}

final class AuthService: IAuthService {
  private var handler: AuthStateDidChangeListenerHandle?
  private let authStorage: UserDefaultsStorage
  
  @MainActor
  var userUid: String? {
    UserDefaults.standard.string(forKey: "userId")
  }
  
  @MainActor
  private let presentedViewController: () async -> UIViewController
  
  init(
    authStorage: UserDefaultsStorage,
    presentedViewController: @MainActor @escaping () -> UIViewController
  ) {
    self.authStorage = authStorage
    self.presentedViewController = presentedViewController
    
    
    handler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
      UserDefaults.standard.set(user?.uid, forKey: "userId")
      print("Current user - \(auth.currentUser)")
      print("User - \(user)")
    }
  }
  
  @MainActor
  func signInWithGoogle() async throws {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      throw UserError.authFailed
    }

    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
    
    let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: await presentedViewController())
    
    guard let idToken = signInResult.user.idToken else {
      throw UserError.authFailed
    }
    
    let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                   accessToken: signInResult.user.accessToken.tokenString)
      
    let user = try await Auth.auth().signIn(with: credential)
    authStorage.save(user.user.uid, key: "userId")
  }
  
  func signOut() throws {
    try Auth.auth().signOut()
    authStorage.erase(key: "userId")
  }
}
