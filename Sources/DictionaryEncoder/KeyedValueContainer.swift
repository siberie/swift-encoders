//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation


struct KeyedValueContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    let codingPath: [CodingKey]
    private let container: KeyedData
    private let ignoreNilValues: Bool

    init(to container: KeyedData, codingPath: [CodingKey] = [], ignoreNilValues: Bool = false) {
        self.container = container
        self.codingPath = codingPath
        self.ignoreNilValues = ignoreNilValues
    }

    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
        guard value != nil || !ignoreNilValues else {
            return
        }
        container.encode(key: codingPath + [key], value: value)
    }

    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws {
        guard value != nil || !ignoreNilValues else {
            return
        }
        container.encode(key: codingPath + [key], value: value)
    }

    mutating func encodeNil(forKey key: Key) throws {
        guard !ignoreNilValues else {
            return
        }
        container.encode(key: codingPath + [key], value: nil)
    }

    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T: Encodable {
        guard value != nil || !ignoreNilValues else {
            return
        }

        if let value {
            try encode(value, forKey: key)
        } else {
            container.encode(key: codingPath + [key], value: nil)
        }
    }

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        if let value = value as? Date {
            container.encode(key: codingPath + [key], value: value)
            return
        }

        let encoder = DictionaryEncoding(
            to: container,
            codingPath: codingPath + [key],
            ignoreNilValues: ignoreNilValues
        )
        try value.encode(to: encoder)
    }

    mutating func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type,
        forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError("nestedContainer(keyedBy:) has not been implemented")
    }

    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        fatalError("nestedUnkeyedContainer(forKey:) has not been implemented")
    }

    func superEncoder() -> Encoder {
        fatalError("superEncoder() has not been implemented")
    }

    func superEncoder(forKey key: Key) -> Encoder {
        fatalError("superEncoder(forKey:) has not been implemented")
    }
}
