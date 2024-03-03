//
//  SplashView.swift
//  Elizabeth
//
//  Created by Дмитрий Трифонов on 02/09/2023.
//

import SwiftUI
import ActivityIndicatorView

struct SplashView: View {
  
  @StateObject
  private var viewModel: SplashViewModel
  
  init(viewModel: SplashViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    PrimaryLoader()
      .onAppear(perform: viewModel.onAppear)
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView(viewModel: .init(services: .mock, navigator: .mock))
  }
}
