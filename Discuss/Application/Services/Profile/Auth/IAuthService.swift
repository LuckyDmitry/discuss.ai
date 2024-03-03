protocol IAuthService {
  var userUid: String? { get }
  func signInWithGoogle() async throws
  func signOut() async throws
}
