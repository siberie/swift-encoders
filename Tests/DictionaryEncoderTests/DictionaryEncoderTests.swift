import XCTest
@testable import DictionaryEncoder

final class DictionaryEncoderTests: XCTestCase {
    func testEmpty() throws {
        struct TestStruct: Encodable {
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 0)
    }

    func testStructWithInt() throws {
        struct TestStruct: Encodable {
            let x = 1
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? Int, 1)
    }

    func testStructWithString() throws {
        struct TestStruct: Encodable {
            let x = "abc"
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? String, "abc")
    }

    func testStructWithDate() throws {
        struct TestStruct: Encodable {
            let x = Date(timeIntervalSince1970: 0)
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? Date, Date(timeIntervalSince1970: 0))
    }

    func testStructWithCodableEnum() throws {
        enum TestEnum: String, Codable {
            case a
            case b
        }

        struct TestStruct: Encodable {
            let x = TestEnum.a
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? String, "a")
    }

    func testStructWithDictionary() throws {
        struct TestStruct: Encodable {
            let x = ["a": 1, "b": 2]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? [String: Int], ["a": 1, "b": 2])
    }

    func testStructWithNestedStruct() throws {
        struct NestedStruct: Encodable {
            let y = 1
        }

        struct TestStruct: Encodable {
            let x = NestedStruct()
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? [String: Int], ["y": 1])
    }

    func testStructWithIntArray() throws {
        struct TestStruct: Encodable {
            let x = [1, 2, 3]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? [Int], [1, 2, 3])
    }

    func testStructWithStringArray() throws {
        struct TestStruct: Encodable {
            let x = ["a", "b", "c"]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["x"] as? [String], ["a", "b", "c"])
    }

    func testStructWithDateArray() throws {
        struct TestStruct: Encodable {
            let x = [Date(timeIntervalSince1970: 0), Date(timeIntervalSince1970: 1)]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual((result["x"] as? [Date])?.count, 2)
        XCTAssertEqual((result["x"] as? [Date])?[0], Date(timeIntervalSince1970: 0))
        XCTAssertEqual((result["x"] as? [Date])?[1], Date(timeIntervalSince1970: 1))

    }


    func testStructWithCodableEnumArray() throws {
        enum TestEnum: String, Codable {
            case a
            case b
        }

        struct TestStruct: Encodable {
            let x = [TestEnum.a, TestEnum.b]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual((result["x"] as? [String])?.count, 2)
        XCTAssertEqual((result["x"] as? [String])?[0], "a")
        XCTAssertEqual((result["x"] as? [String])?[1], "b")
    }

    func testStructWithDictionaryArray() throws {
        struct TestStruct: Encodable {
            let x = [["a": 1], ["b": 2]]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual((result["x"] as? [[String: Int]])?.count, 2)
        XCTAssertEqual((result["x"] as? [[String: Any?]])?[0]["a"] as? Int, 1)
        XCTAssertEqual((result["x"] as? [[String: Any?]])?[1]["b"] as? Int, 2)
    }


    func testStructWithNestedStructArray() throws {
        struct NestedStruct: Encodable {
            let y: Int
        }

        struct TestStruct: Encodable {
            let x = [NestedStruct(y: 1), NestedStruct(y: 2)]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual((result["x"] as? [Any])?.count, 2)
        XCTAssertEqual((result["x"] as? [[String: Any?]])?[0]["y"] as? Int, 1)
        XCTAssertEqual((result["x"] as? [[String: Any?]])?[1]["y"] as? Int, 2)
    }

    func testStructWithOptionalInt() throws {
        struct TestStruct: Encodable {
            let x: Int? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalString() throws {
        struct TestStruct: Encodable {
            let x: String? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalDate() throws {
        struct TestStruct: Encodable {
            let x: Date? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalDictionary() throws {
        struct TestStruct: Encodable {
            let x: [String: Int]? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalNestedStruct() throws {
        struct NestedStruct: Encodable {
            let y: Int = 1
        }

        struct TestStruct: Encodable {
            let x: NestedStruct? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalIntArray() throws {
        struct TestStruct: Encodable {
            let x: [Int]? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalStringArray() throws {
        struct TestStruct: Encodable {
            let x: [String]? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalDateArray() throws {
        struct TestStruct: Encodable {
            let x: [Date]? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalDictionaryArray() throws {
        struct TestStruct: Encodable {
            let x: [[String: Int]]? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithOptionalNestedStructArray() throws {
        struct NestedStruct: Encodable {
            let y: Int = 1
        }

        struct TestStruct: Encodable {
            let x: [NestedStruct]? = nil
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertNil(result["x"]!)
    }

    func testStructWithArrayOfOptionalInt() throws {
        struct TestStruct: Encodable {
            let x: [Int?] = [1, nil, 2]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
    }

    func testStructWithArrayOfOptionalString() throws {
        struct TestStruct: Encodable {
            let x: [String?] = ["a", nil, "b"]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
    }

    func testStructWithArrayOfOptionalDate() throws {
        struct TestStruct: Encodable {
            let x: [Date?] = [Date(timeIntervalSince1970: 0), nil, Date(timeIntervalSince1970: 1)]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
    }

    func testStructWithArrayOfOptionalDictionary() throws {
        struct TestStruct: Encodable {
            let x: [[String: Int]?] = [["a": 1], nil, ["b": 2]]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
    }

    func testStructWithArrayOfOptionalNestedStruct() throws {
        struct NestedStruct: Encodable {
            let y: Int = 1
        }

        struct TestStruct: Encodable {
            let x: [NestedStruct?] = [NestedStruct(), nil, NestedStruct()]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
    }

    func testStructWithArrayOfArrays() throws {
        struct TestStruct: Encodable {
            let x: [[Int]] = [[1, 2], [3, 4]]
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
    }

    func testStructWithTwoInts() throws {
        struct TestStruct: Encodable {
            let x = 1
            let y = 2
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 2)
        XCTAssertEqual(result["x"] as? Int, 1)
        XCTAssertEqual(result["y"] as? Int, 2)
    }

    func testStructWithTwoStrings() throws {
        struct TestStruct: Encodable {
            let x = "a"
            let y = "b"
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 2)
        XCTAssertEqual(result["x"] as? String, "a")
        XCTAssertEqual(result["y"] as? String, "b")
    }

    func testStructWithCodingKeys() throws {
        struct TestStruct: Encodable {
            let x = 1
            let y = 2

            enum CodingKeys: String, CodingKey {
                case x = "a"
                case y = "b"
            }
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 2)
        XCTAssertEqual(result["a"] as? Int, 1)
        XCTAssertEqual(result["b"] as? Int, 2)
    }
    func testStructWithCodingKeysNotFull() throws {
        struct TestStruct: Encodable {
            let x = 1
            let y = 2

            enum CodingKeys: String, CodingKey {
                case x = "a"
            }
        }

        let testData = TestStruct()

        let result = DictionaryEncoder.encode(testData)

        XCTAssertNotNil(result)
        XCTAssertEqual(result.keys.count, 1)
        XCTAssertEqual(result["a"] as? Int, 1)
    }
}
