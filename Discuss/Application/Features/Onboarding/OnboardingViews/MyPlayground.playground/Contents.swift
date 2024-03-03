import UIKit
import Combine

class A {
    
    var ob: Int = 324
    
    
}

class B {
    @Published
    var a = A()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $a. sink { newA in
            print(newA  )
        }
        .store(in: &cancellables)
    }
}

let b = B()

b.a.ob += 12

