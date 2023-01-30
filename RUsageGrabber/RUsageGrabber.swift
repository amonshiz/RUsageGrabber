//
// Created by Andrew Monshizadeh on 1/25/23.
//

import Foundation
import Darwin.POSIX.sys.resource
import Darwin

struct RUsageGrabber {
    let results: AsyncThrowingStream<rusage_info_current, Error>

    init() {
        let pid = getpid()
        results = .init(unfolding: {
            try await Task.sleep(for: .seconds(2))
            var usage = rusage_info_current()

            let result = withUnsafeMutablePointer(to: &usage) {
                $0.withMemoryRebound(to: rusage_info_t?.self, capacity: 1) { pointer in
                    proc_pid_rusage(pid, RUSAGE_INFO_CURRENT, pointer)
                }
            }

            return usage
        })
    }
}
