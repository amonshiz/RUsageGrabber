//
//  ContentView.swift
//  RUsageGrabber
//
//  Created by Andrew Monshizadeh on 1/25/23.
//

import SwiftUI

struct ContentView: View {
    var grabber: RUsageGrabber
    @State var previousUsage: rusage_info_current = .init()
    @State var currentUsage: rusage_info_current = .init()
    @State var previousTime: TimeInterval = 0
    @State var recentTime: TimeInterval = 0
    @State var timeDiff: UInt64 = 0
    @State var previousText: String = ""
    @State var currentText: String = ""
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
        Text("user time diff: \(Double(timeDiff) / Double(NSEC_PER_SEC))")
        Text("time diff: \(recentTime - previousTime)")
        HStack {
            Text(previousText)
            Text(currentText)
        }
    }
      .padding()
      .task {
          do {
              for try await r in grabber.results {
                  previousTime = recentTime
                  recentTime = CACurrentMediaTime()
                  previousText = currentText
                  var res = ""
                  dump(r, to: &res)
                  currentText = res
                  timeDiff = r.ri_user_time - previousUsage.ri_user_time
                  previousUsage = r
                  currentUsage = r
              }
          } catch {
              fatalError("Things failed")
          }
      }
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}
