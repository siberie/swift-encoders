//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation


struct KeyedValueContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    let codingPath: [CodingKey]
    private let container: KeyedData

    init(to container: KeyedData, codingPath: [CodingKey] = []) {
        self.container = container
        self.codingPath = codingPath
    }

    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
        print("KeyedValueContainer.encodeIfPresent(_:forKey:)")
        container.encode(key: codingPath + [key], value: value)
    }

    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws {
        print("KeyedValueContainer.encodeIfPresent(_:forKey:)")
        container.encode(key: codingPath + [key], value: value)
    }

    mutating func encodeNil(forKey key: Key) throws {
        print("KeyedValueContainer.encodeNil(forKey:)")
        container.encode(key: codingPath + [key], value: nil)
    }

    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T: Encodable {
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

        let encoder = DictionaryEncoding(to: container, codingPath: codingPath + [key])
        try value.encode(to: encoder)
    }

    mutating func nestedContainer<NestedKey>(
        keyedBy keyType: NestedKey.Type,
        forKey key: Key
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        let data = KeyedData()
        container.encode(key: codingPath + [key], data: data)

        let container = KeyedValueContainer<NestedKey>(to: data, codingPath: codingPath + [key])
        return KeyedEncodingContainer(container)
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
