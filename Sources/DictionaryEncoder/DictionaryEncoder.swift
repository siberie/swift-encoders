//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation

public class DictionaryEncoder {
    public static func encode<T: Encodable>(_ value: T) -> [String: Any?] {
        let encoder = DictionaryEncoding(to: RootData())
        try! value.encode(to: encoder)
        return encoder.output!
    }
}

struct DictionaryEncoding: Encoder {
    private(set) var codingPath: [CodingKey]
    private(set) var userInfo: [CodingUserInfoKey: Any] = [:]
    private let data: DataProtocol

    public init(to data: DataProtocol, codingPath: [CodingKey] = []) {
        self.data = data
        self.codingPath = codingPath
    }

    var output: Dictionary<String, Any?>? {
        data.value as? Dictionary<String, Any?>
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let data = KeyedData()
        self.data.encode(key: codingPath, data: data)

        let container = KeyedValueContainer<Key>(to: data, codingPath: codingPath)

        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let data = UnkeyedData()
        self.data.encode(key: codingPath, data: data)
        return UnkeyedValueContainer(to: data, codingPath: codingPath)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        let data = SingleData()
        self.data.encode(key: codingPath, data: data)

        return SingleValueContainer(to: data, codingPath: codingPath)
    }
}
