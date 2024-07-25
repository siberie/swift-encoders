//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation

struct SingleValueContainer: SingleValueEncodingContainer {
    let codingPath: [CodingKey]
    private let container: SingleData

    init(to container: SingleData, codingPath: [CodingKey] = []) {
        self.container = container
        self.codingPath = codingPath
    }

    mutating func encodeNil() throws {
        container.encode(key: codingPath, value: nil)
    }

    mutating func encode(_ value: Int) throws {
        self.container.encode(key: codingPath, value: value)
    }

    mutating func encode(_ value: String) throws {
        self.container.encode(key: codingPath, value: value)
    }

    mutating func encode(_ value: Date) throws {
        self.container.encode(key: codingPath, value: value)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        if let value = value as? Date {
            container.encode(key: codingPath, value: value)
            return
        }

        let encoder = DictionaryEncoding(to: container, codingPath: codingPath)
        try value.encode(to: encoder)
    }
}
