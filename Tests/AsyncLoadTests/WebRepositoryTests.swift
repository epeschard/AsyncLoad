//
//  WebRepositoryTests.swift
//  AsyncLoad
//
//  Created by Alexey Naumov on 31.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import XCTest
import Combine
@testable import AsyncLoad

class WebRepositoryTests: WebRepository {
    let session: URLSession = .mockedResponsesOnly
    let host = "test.com"
    let bgQueue = DispatchQueue(label: "test")
}
