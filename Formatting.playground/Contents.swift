//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import Formatting
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center

        view.addSubview(label)
        self.view = view

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        let input = "M1 delivers up to <b>2.8x faster</b> processing performance than the <a href='%@'>previous generation.</a>"
        let text = String(format: input, "https://support.apple.com/kb/SP799")
        let style = FormattedStringStyle(attributes: [
            "body": [.font: UIFont.systemFont(ofSize: 15)],
            "b": [.font: UIFont.boldSystemFont(ofSize: 15)],
            "a": [.underlineColor: UIColor.clear]
        ])
        label.attributedText = NSAttributedString(formatting: text, style: style)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
