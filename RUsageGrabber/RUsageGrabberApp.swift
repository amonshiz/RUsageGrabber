//
//  RUsageGrabberApp.swift
//  RUsageGrabber
//
//  Created by Andrew Monshizadeh on 1/25/23.
//

import SwiftUI

@main
struct RUsageGrabberApp: App {
    let grabber = RUsageGrabber()
  var body: some Scene {
    WindowGroup {
        ContentView(grabber: grabber)
    }
  }
}
