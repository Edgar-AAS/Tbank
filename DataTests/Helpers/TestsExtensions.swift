//
//  TestsExtensions.swift
//  DataTests
//
//  Created by Leonardo Almeida on 07/02/23.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
