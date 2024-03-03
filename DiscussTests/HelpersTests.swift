import XCTest

final class ElizabethStringTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testStringsSplitter() {
    let firstString = "Hello! How are you doing? I hope everything alright."
    let result = firstString.customSplit(byCharacters: "!?.")
    XCTAssertEqual(result, ["Hello!", " How are you doing?", " I hope everything alright."])
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}

extension String {

  public func customSplit(byCharacters characters: String) -> [String] {
    var substrings: [String] = []
    
    var currentSubstring = ""
    for char in self {
      if characters.contains(char) {
        if !currentSubstring.isEmpty {
          currentSubstring.append(char)
          substrings.append(currentSubstring)
          currentSubstring = ""
        }
      } else {
        currentSubstring.append(char)
      }
    }
    
    if !currentSubstring.isEmpty {
      substrings.append(currentSubstring)
    }
    
    return substrings
  }
}
