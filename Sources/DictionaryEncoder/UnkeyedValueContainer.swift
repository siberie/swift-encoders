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

    init(to container: UnkeyedData, codingPath: [CodingKey] = []) {
        self.container = container
        self.codingPath = codingPath
    }

    mutating func encodeNil() throws {
        container.encode(key: codingPath, value: nil)
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

        let encoder = DictionaryEncoding(to: container, codingPath: codingPath)
        try value.encode(to: encoder)
    }

    mutating func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        let data = KeyedData()
        container.encode(key: codingPath, data: data)

        let container = KeyedValueContainer<NestedKey>(to: data, codingPath: codingPath)
        return KeyedEncodingContainer(container)
    }

    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let data = UnkeyedData()
        container.encode(key: codingPath, data: data)
        let container = UnkeyedValueContainer(to: data, codingPath: codingPath)
        return container
    }

    func superEncoder() -> Encoder {
        fatalError("superEncoder() has not been implemented")
    }
}
