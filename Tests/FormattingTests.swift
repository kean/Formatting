// The MIT License (MIT)
//
// Copyright (c) 2020 Alexander Grebenyuk (github.com/kean).

import XCTest
import Formatting

class FormattingsTests: XCTestCase {

    func testBodyFont() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
        ])

        // WHEN
        let input = "Hello"
        let output = NSAttributedString(formatting: input, style: style)

        // THEN
        let allAttributes = output.attributes
        XCTAssertEqual(allAttributes.count, 1)

        do {
            let body = try XCTUnwrap(allAttributes.first { $0.range == NSRange(0..<5) }?.attributes)
            XCTAssertEqual(body.count, 1)

            let font = try XCTUnwrap(body[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }
    }

    func testBoldFont() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!],
            "b": [.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!]
        ])

        // WHEN
        let input = "Hello <b>World</b>"
        let output = NSAttributedString(formatting: input, style: style)

        // THEN
        let allAttributes = output.attributes
        XCTAssertEqual(allAttributes.count, 2)

        do {
            let body = try XCTUnwrap(allAttributes.first { $0.range == NSRange(0..<6) }?.attributes)
            XCTAssertEqual(body.count, 1)

            let font = try XCTUnwrap(body[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }

        do {
            let bold = try XCTUnwrap(allAttributes.first { $0.range == NSRange(6..<11) }?.attributes)
            XCTAssertEqual(bold.count, 1)

            let font = try XCTUnwrap(bold[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Medium")
            XCTAssertEqual(font.pointSize, 20)
        }
    }

    func testLink() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
        ])

        // WHEN
        let input = "Tap <a class='custom-class' href=\"https://google.com\">this</a>"
        let output = NSAttributedString(formatting: input, style: style)

        // THEN
        let allAttributes = output.attributes
        XCTAssertEqual(allAttributes.count, 2)

        do {
            let body = try XCTUnwrap(allAttributes.first { $0.range == NSRange(0..<4) }?.attributes)
            XCTAssertEqual(body.count, 1)

            let font = try XCTUnwrap(body[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }

        do {
            let link = try XCTUnwrap(allAttributes.first { $0.range == NSRange(4..<8) }?.attributes)
            XCTAssertEqual(link.count, 2)

            let url = try XCTUnwrap(link[.link] as? URL)
            XCTAssertEqual(url.absoluteString, "https://google.com")

            let font = try XCTUnwrap(link[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }
    }

    func testLinkWithAmpersands() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
        ])

        // WHEN
        let input = "Tap <a href=\"https://google.com?a=1&b=2\">this</a>"
        let output = NSAttributedString(formatting: input, style: style)

        // THEN
        let allAttributes = output.attributes
        XCTAssertEqual(allAttributes.count, 2)

        XCTAssertEqual(output.string, "Tap this")

        do {
            let body = try XCTUnwrap(allAttributes.first { $0.range == NSRange(0..<4) }?.attributes)
            XCTAssertEqual(body.count, 1)

            let font = try XCTUnwrap(body[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }

        do {
            let link = try XCTUnwrap(allAttributes.first { $0.range == NSRange(4..<8) }?.attributes)
            XCTAssertEqual(link.count, 2)

            let url = try XCTUnwrap(link[.link] as? URL)
            XCTAssertEqual(url.absoluteString, "https://google.com?a=1&b=2")

            let font = try XCTUnwrap(link[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }
    }

    func testLineBreaks() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
        ])

        func format(_ string: String) -> String {
            NSAttributedString(formatting: string, style: style).string
        }

        // WHEN/THEN
        XCTAssertEqual(format("a<br>b"), "a\u{2028}b")
        XCTAssertEqual(format("a<br/>b"), "a\u{2028}b")
        XCTAssertEqual(format("a<br />b"), "a\u{2028}b")
    }

    // This used to result in a crash https://github.com/kean/Formatting/issues/1
    // because of the String index mutation during `append`
    func testCyrillicText() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!],
            "b": [.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!]
        ])

        // WHEN
        let input = "Если вы забыли свой пароль на новом устройстве, вам также будет отправлен <b>6-значный код проверки</b>"
        let output = NSAttributedString(formatting: input, style: style)

        // THEN
        let allAttributes = output.attributes
        XCTAssertEqual(allAttributes.count, 2)

        do {
            let body = try XCTUnwrap(allAttributes.first { $0.range == NSRange(0..<74) }?.attributes)
            XCTAssertEqual(body.count, 1)

            let font = try XCTUnwrap(body[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Light")
            XCTAssertEqual(font.pointSize, 20)
        }

        do {
            let bold = try XCTUnwrap(allAttributes.first { $0.range == NSRange(74..<96) }?.attributes)
            XCTAssertEqual(bold.count, 1)

            let font = try XCTUnwrap(bold[.font] as? UIFont)
            XCTAssertEqual(font.fontName, "HelveticaNeue-Medium")
            XCTAssertEqual(font.pointSize, 20)
        }
    }

    func testEmoji() throws {
        // GIVEN
        let style = FormattedStringStyle(attributes: [
            "t": [.foregroundColor: UIColor.red]
        ])

        // WHEN
        let input = "⚠ Text with <t>emoji</t>"
        let output = NSAttributedString(formatting: input, style: style)

        //  THEN
        let allAttributes = output.attributes
        XCTAssertEqual(allAttributes.count, 2)

        let colorAttribute = try XCTUnwrap(allAttributes.first { $0.attributes.first?.key == NSAttributedString.Key.foregroundColor })
        let range = colorAttribute.range
        XCTAssertEqual((output.string as NSString).substring(with: range), "emoji")
    }
}

private extension NSAttributedString {
    var attributes: [(range: NSRange, attributes: [NSAttributedString.Key: Any])] {
        var output = [(NSRange, [NSAttributedString.Key: Any])]()
        var range = NSRange()
        var index = 0

        while index < length {
            let attributes = self.attributes(at: index, effectiveRange: &range)
            output.append((range, attributes))
            index = max(index + 1, Range(range)?.endIndex ?? 0)
        }
        return output
    }
}
