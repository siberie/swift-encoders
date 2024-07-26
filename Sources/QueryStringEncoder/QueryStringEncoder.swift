import Foundation

public class QueryStringEncoder {
    public init() {
    }

    public func encode<T: Encodable>(_ value: T) throws -> String {
        let encoder = QueryParametersEncoder()
        try value.encode(to: encoder)
        guard let output = encoder.output else {
            throw EncodingError.invalidValue(
                value,
                EncodingError.Context(codingPath: [], debugDescription: "Failed to encode value")
            )
        }
        return output
    }
}

struct QueryParametersEncoder: Encoder {
    private(set) var codingPath: [CodingKey]
    private(set) var userInfo: [CodingUserInfoKey: Any] = [:]
    private let data: Data

    public init(to data: Data = Data(), codingPath: [CodingKey] = []) {
        self.data = data
        self.codingPath = codingPath
    }

    var output: String? {
        var components = URLComponents()
        components.queryItems = data.items.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        return components.percentEncodedQuery
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
        let container = KeyedQueryStringEncodingContainer<Key>(to: data, codingPath: codingPath)
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("unkeyedContainer() has not been implemented")
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        SingleValueContainer(to: data, codingPath: codingPath)
    }
}

extension QueryParametersEncoder {
    final class Data {
        var items: [(key: String, value: String)] = []

        func encode(key: [CodingKey], value: String) {
            let keyString = key.map(\.stringValue).joined(separator: ".")
            items.append((key: keyString, value: value))
        }
    }
}
