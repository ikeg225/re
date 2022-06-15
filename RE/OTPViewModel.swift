//
//  OTPViewModel.swift
//  RE
//
//  Created by Ethan Ikegami on 6/14/22.
//

import SwiftUI

class OTPViewModel: ObservableObject {
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 5)
}
