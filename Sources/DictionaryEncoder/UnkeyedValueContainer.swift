//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation


struct UnkeyedValueContainer: UnkeyedEncodingContainer {
    var count: Int {
        container.values.count
    }

    let codingPath: [CodingKey]
    private let container: UnkeyedData
    private let ignoreNilValues: Bool


    init(to container: UnkeyedData, codingPath: [CodingKey] = [], ignoreNilValues: Bool = false) {
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

    mutating func encodeIfPresent(_ value: Int?) throws {
        guard value != nil || !ignoreNilValues else {
            return
        }
        container.encode(key: codingPath, value: value)
    }

    mutating func encodeIfPresent(_ value: String?) throws {
        guard value != nil || !ignoreNilValues else {
            return
        }
        container.encode(key: codingPath, value: value)
    }

    mutating func encodeIfPresent<T>(_ value: T?) throws where T: Encodable {
        guard value != nil || !ignoreNilValues else {
            return
        }

        if let value {
            try encode(value)
        } else {
            container.encode(key: codingPath, value: nil)
        }
    }

    mutating func encode(_ value: Int) throws {
        container.encode(key: codingPath, value: value)
    }

    func encode<T>(contentsOf sequence: T) throws where T: Sequence, T.Element: Encodable {
        container.encode(key: codingPath, value: sequence)
    }

    mutating func encode<T>(_ value: T) throws where T: Encodable {
        if let value = value as? Date {
            container.encode(key: codingPath, value: value)
            return
        }

        let encoder = DictionaryEncoding(to: container, codingPath: codingPath, ignoreNilValues: ignoreNilValues)
        try value.encode(to: encoder)
    }

    mutating func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError("nestedContainer(keyedBy:) has not been implemented")
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("nestedContainer(keyedBy:) has not been implemented")
    }

    func superEncoder() -> Encoder {
        fatalError("superEncoder() has not been implemented")
    }
}
