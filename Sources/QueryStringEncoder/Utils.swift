import Foundation

let allowedCharacters = CharacterSet(
    charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~-._"
)

let iso8601DateFormatter = {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return dateFormatter
}()