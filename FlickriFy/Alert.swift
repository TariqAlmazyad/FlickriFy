//
//  Alert.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 12/1/20.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {

    static let invalidData = AlertItem(title: Text("Server Error"),
                                              message: Text("The data received from the server was invalid. Please contact support."),
                                              dismissButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid response from the server. Please try again later or contact support."),
                                              dismissButton: .default(Text("OK")))
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                              message: Text("There was issue contacting the server. If persists,  Please try again later or contact support."),
                                              dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                              message: Text("Unable to complete your request at this time. If persists,  Please try again later or contact support."),
                                              dismissButton: .default(Text("OK")))
}
