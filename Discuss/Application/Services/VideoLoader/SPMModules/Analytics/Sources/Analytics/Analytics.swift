import FirebaseCore
import FirebaseAnalytics

public struct Event {
  public var name: String
  public var parameters: [String: Any]?
  
  init(name: String, parameters: [String : Any]?) {
    self.name = name
    self.parameters = parameters
  }
}

public struct Telemetry {
  public var log: (Event) -> Void
  
  public static func configure() {
  }
}

public extension Telemetry {
  static let live = Self(log: { event in
    Analytics.logEvent(event.name, parameters: event.parameters)
  })
}
