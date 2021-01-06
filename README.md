# Formatting

An example code for [kean.blog: Formatted Localizable Strings](https://kean.blog/post/formatted-strings). Demonstrates how to implement basic string formatting using XML tags. 

```swift
let input = "M1 delivers up to <b>2.8x faster</b> processing performance than the <a href='%@'>previous generation.</a>"
let text = String(format: input, "https://support.apple.com/kb/SP799")
let style = FormattedStringStyle(attributes: [
    "body": [.font: UIFont.systemFont(ofSize: 15)],
    "b": [.font: UIFont.boldSystemFont(ofSize: 15)],
    "a": [.underlineColor: UIColor.clear]
])
label.attributedText = NSAttributedString(formatting: text, style: style)
```

Result using standard `UILabel`:

![Screen Shot 2020-11-29 at 18 07 03](https://user-images.githubusercontent.com/1567433/100556269-29dc6380-326f-11eb-8afe-769d48706362.png)


# License

Formatting is available under the MIT license. See the LICENSE file for more info.
