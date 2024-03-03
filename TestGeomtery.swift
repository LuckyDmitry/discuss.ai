//
//  TestGeomtery.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 13/10/2023.
//

import SwiftUI

struct TestGeomtery: View {
    @Namespace
    var test
    
    var id = "identifier"
    
    var teset = "testtt"
    
    @State
    var anotherView: Bool = false
    
    var body: some View {
        VStack {
            if anotherView {
                VStack {
                    Text("Hello world")
                        .matchedGeometryEffect(id: teset, in: test)
                        .background(
                    Rectangle()
                        .foregroundColor(.red)
                        .matchedGeometryEffect(id: id, in: test)
                        .frame(maxWidth: 300, maxHeight: 400)
                    )
                    Spacer()
                }
            } else {
                Text("Hello world")
                    .matchedGeometryEffect(id: teset, in: test)
                    .background(
                Rectangle()
                    .foregroundColor(.red)
                    .matchedGeometryEffect(id: id, in: test)
                    .frame(width: 450, height: 400)
                )
            }
        }
        .animation(.linear(duration: 2), value: anotherView)
        .frame(width: .infinity, height: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            anotherView.toggle()
        }
    }
}

struct TestGeomtery_Previews: PreviewProvider {
    static var previews: some View {
        TestGeomtery()
    }
}
