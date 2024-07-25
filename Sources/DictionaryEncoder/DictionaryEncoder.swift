//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation

public class DictionaryEncoder {
    let ignoreNilValues: Bool

    public init(ignoreNilValues: Bool = false) {
        self.ignoreNilValues = ignoreNilValues
    }

    public func encode<T>(_ value: T) throws -> [String: Any?] where T: Encodable {
        let encoder = DictionaryEncoding(to: RootData(), ignoreNilValues: ignoreNilValues)
        try value.encode(to: encoder)
        return encoder.output!
    }

    public func encode<T>(
        _ value: T
    ) throws -> [[String: Any?]] where T: Encodable, T: Collection, T.Element: Encodable {
        try value.map {
            try encode($0)
        }
    }
}

struct DictionaryEncoding: Encoder {
    private(set) var codingPath: [CodingKey]
    private(set) var userInfo: [CodingUserInfoKey: Any] = [:]
    private let data: DataProtocol
    private let ignoreNilValues: Bool

    public init(to data: DataProtocol, codingPath: [CodingKey] = [], ignoreNilValues: Bool = false) {
        self.data = data
        self.codingPath = codingPath
        self.ignoreNilValues = ignoreNilValues
    }

    var output: Dictionary<String, Any?>? {
        data.value as? Dictionary<String, Any?>
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let data = KeyedData()
        self.data.encode(key: codingPath, data: data)

        let container = KeyedValueContainer<Key>(to: data, codingPath: codingPath, ignoreNilValues: ignoreNilValues)

        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        let data = UnkeyedData()
        self.data.encode(key: codingPath, data: data)
        return UnkeyedValueContainer(to: data, codingPath: codingPath, ignoreNilValues: ignoreNilValues)
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        let data = SingleData()
        self.data.encode(key: codingPath, data: data)

        return SingleValueContainer(to: data, codingPath: codingPath, ignoreNilValues: ignoreNilValues)
    }
}
