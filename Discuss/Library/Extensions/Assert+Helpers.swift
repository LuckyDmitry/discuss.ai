//
//  Assert+Helpers.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 09.04.2023.
//

import Foundation

func assertIsMainThread() {
  assert(Thread.isMainThread)
}
