//
//  UpdateStore.swift
//  firstTest
//
//  Created by MDavid Low on 10/13/20.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
