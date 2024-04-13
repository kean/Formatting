// The MIT License (MIT)
//
// Copyright (c) 2020-2024 Alexander Grebenyuk (github.com/kean).

import XCTest
import Formatting

class FormattingsPerformanceTests: XCTestCase {
    let input = """
    Let's test <b>bold</b>.<br><br>And a link <a href="http://google.com">google</a>.
    """

    func testFormattingPerformance() {
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont(name: "HelveticaNeue-Light", size: 20)!]
        ])

        measure {
            for _ in 0...50 {
                let _ = NSAttributedString(formatting: input, style: style)
            }
        }
    }

    func testHTMLParsingPerformance() {
        let data = input.data(using: .utf8)!
        measure {
            for _ in 0...50 {
                let _ = try! NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            }
        }
    }
}
