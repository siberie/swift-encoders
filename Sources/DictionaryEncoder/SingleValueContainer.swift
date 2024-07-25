//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation

struct SingleValueContainer: SingleValueEncodingContainer {
    let codingPath: [CodingKey]
    private let container: SingleData
    private let ignoreNilValues: Bool

    init(to container: SingleData, codingPath: [CodingKey] = [], ignoreNilValues: Bool = false) {
        self.container = container
        self.codingPath = codingPath
        self.ignoreNilValues = ignoreNilValues
    }

    mutating func encodeNil() throws {
        guard !ignoreNilValues else {
            return
        }

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

        let encoder = DictionaryEncoding(to: container, codingPath: codingPath, ignoreNilValues: ignoreNilValues)
        try value.encode(to: encoder)
    }
}
