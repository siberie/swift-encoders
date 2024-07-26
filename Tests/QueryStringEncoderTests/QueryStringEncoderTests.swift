import XCTest
@testable import QueryStringEncoder

final class QueryStringEncoderTests: XCTestCase {
    func testEncodeOneIntField() throws {
        struct Test: Encodable {
            let x = 1
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=1")
    }

    func testEncodeTwoIntFields() throws {
        struct Test: Encodable {
            let x = 1
            let y = 2
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=1&y=2")
    }

    func testEncodeTwoIntFieldsReverseOrder() throws {
        struct Test: Encodable {
            let y = 2
            let x = 1
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "y=2&x=1")
    }

    func testEncodeStringField() throws {
        struct Test: Encodable {
            let x = "Monty"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty")
    }

    func testEncodeStringFieldWithSpace() throws {
        struct Test: Encodable {
            let x = "Monty Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%20Python")
    }

    func testEncodeStringFieldWithPercent() throws {
        struct Test: Encodable {
            let x = "Monty%Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%25Python")
    }

    func testEncodeStringFieldWithAmpersand() throws {
        struct Test: Encodable {
            let x = "Monty&Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%26Python")
    }

    func testEncodeStringFieldWithEqual() throws {
        struct Test: Encodable {
            let x = "Monty=Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%3DPython")
    }

    func testEncodeStringFieldWithPlus() throws {
        struct Test: Encodable {
            let x = "Monty+Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%2BPython")
    }

    func testEncodeStringFieldWithQuestionMark() throws {
        struct Test: Encodable {
            let x = "Monty?Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%3FPython")
    }

    func testEncodeStringFieldWithHash() throws {
        struct Test: Encodable {
            let x = "Monty#Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%23Python")
    }

    func testEncodeStringFieldWithSlash() throws {
        struct Test: Encodable {
            let x = "Monty/Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%2FPython")
    }

    func testEncodeStringFieldWithColon() throws {
        struct Test: Encodable {
            let x = "Monty:Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%3APython")
    }

    func testEncodeStringFieldWithSemicolon() throws {
        struct Test: Encodable {
            let x = "Monty;Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%3BPython")
    }

    func testEncodeStringFieldWithComma() throws {
        struct Test: Encodable {
            let x = "Monty,Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%2CPython")
    }

    func testEncodeStringFieldWithDollar() throws {
        struct Test: Encodable {
            let x = "Monty$Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%24Python")
    }

    func testEncodeStringFieldWithAsterisk() throws {
        struct Test: Encodable {
            let x = "Monty*Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%2APython")
    }

    func testEncodeStringFieldWithExclamationMark() throws {
        struct Test: Encodable {
            let x = "Monty!Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%21Python")
    }

    func testEncodeStringFieldWithAt() throws {
        struct Test: Encodable {
            let x = "Monty@Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%40Python")
    }

    func testEncodeStringFieldWithTilde() throws {
        struct Test: Encodable {
            let x = "Monty~Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty~Python")
    }

    func testEncodeStringFieldWithCircumflex() throws {
        struct Test: Encodable {
            let x = "Monty^Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%5EPython")
    }

    func testEncodeStringFieldWithLeftParenthesis() throws {
        struct Test: Encodable {
            let x = "Monty(Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%28Python")
    }

    func testEncodeStringFieldWithRightParenthesis() throws {
        struct Test: Encodable {
            let x = "Monty)Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%29Python")
    }

    func testEncodeStringFieldWithLeftSquareBracket() throws {
        struct Test: Encodable {
            let x = "Monty[Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%5BPython")
    }

    func testEncodeStringFieldWithRightSquareBracket() throws {
        struct Test: Encodable {
            let x = "Monty]Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%5DPython")
    }

    func testEncodeStringFieldWithLeftCurlyBracket() throws {
        struct Test: Encodable {
            let x = "Monty{Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%7BPython")
    }

    func testEncodeStringFieldWithRightCurlyBracket() throws {
        struct Test: Encodable {
            let x = "Monty}Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%7DPython")
    }

    func testEncodeStringFieldWithPipe() throws {
        struct Test: Encodable {
            let x = "Monty|Python"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=Monty%7CPython")
    }

    func testTwoIntsAndString() throws {
        struct Test: Encodable {
            let x = 1
            let y = 2
            let z = "Tomek"
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "x=1&y=2&z=Tomek")
    }

    func testDateField() throws {
        struct Test: Encodable {
            let date = Date(timeIntervalSince1970: 0)
        }

        let encoder = QueryStringEncoder()
        let result = try encoder.encode(Test())
        XCTAssertEqual(result, "date=1970-01-01T00%3A00%3A00.000Z")
    }

    func testFoobarStruct() throws {
        struct Data: Encodable {
            let foo: String
            let bar: Int
        }

        let encoder = QueryStringEncoder()
        let data = Data(foo: "foo", bar: 42)
        let query = try encoder.encode(data)
        XCTAssertEqual(query, "foo=foo&bar=42")
    }
}
