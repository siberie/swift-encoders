//
// Created by Tomasz Stachowiak on 25.7.2024.
//

import Foundation

protocol DataProtocol {
    var value: Any? { get }

    func encode(key: [CodingKey], value: Any?)
    func encode(key: [CodingKey], data: DataProtocol)
}

class RootData: DataProtocol {
    var data: DataProtocol?

    var value: Any? {
        data?.value
    }

    func encode(key: [CodingKey], value: Any?) {
    }

    func encode(key: [CodingKey], data: DataProtocol) {
        self.data = data
    }
}

class KeyedData: DataProtocol {
    var data = [String: DataProtocol]()

    var value: Any? {
        data.mapValues {
            $0.value
        }
    }

    func encode(key: [CodingKey], value: Any?) {
        let key = key.last!.stringValue
        data[key] = SingleData(value: value)
    }

    func encode(key: [CodingKey], data: DataProtocol) {
        let key = key.last!.stringValue
        self.data[key] = data
    }
}

class SingleData: DataProtocol {
    var data: DataProtocol?
    var singleValue: Any?
    var value: Any? {
        data?.value ?? singleValue
    }

    init(value: Any? = nil) {
        singleValue = value
    }

    func encode(key: [CodingKey], value: Any?) {
        singleValue = value
    }

    func encode(key: [CodingKey], data: DataProtocol) {
        self.data = data
    }
}

class UnkeyedData: DataProtocol {
    var values = [DataProtocol]()

    var value: Any? {
        values.map {
            $0.value
        }
    }

    func encode(key: [CodingKey], value: Any?) {
        values.append(SingleData(value: value))
    }

    func encode(key: [CodingKey], data: DataProtocol) {
        values.append(data)
    }
}
