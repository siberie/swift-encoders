//
// Created by Tomasz Stachowiak on 15.01.24.
//

import Foundation

struct SingleValueContainer: SingleValueEncodingContainer {
    let codingPath: [CodingKey]
    private let container: QueryParametersEncoder.Data

    init(to container: QueryParametersEncoder.Data, codingPath: [CodingKey] = []) {
        self.container = container
        self.codingPath = codingPath
    }

    mutating func encodeNil() throws {
        container.encode(key: codingPath, value: "")
    }

    mutating func encode(_ value: Bool) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: String) throws {
        container.encode(
            key: codingPath,
            value: value.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        )
    }

    mutating func encode(_ value: Double) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: Float) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: Int) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: Int8) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: Int16) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: Int32) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: Int64) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: UInt) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: UInt8) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: UInt16) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: UInt32) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode(_ value: UInt64) throws {
        container.encode(key: codingPath, value: value.description)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        let encoder = QueryParametersEncoder(to: container, codingPath: codingPath)
        try value.encode(to: encoder)
    }
}
