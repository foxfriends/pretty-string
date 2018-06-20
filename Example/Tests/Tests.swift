// https://github.com/Quick/Quick

import Quick
import Nimble
import PrettyString

class PrettyStringSpec: QuickSpec {
    override func spec() {
        describe("PrettyString") {
            it("should parse a regular string") {
                let attributedString = NSAttributedString(string: "hello this is a string")
                let prettyString = try? PrettyString("hello this is a string").parse()
                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should parse a string with a single attribute") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "hello this is a "))
                attributedString.append(NSAttributedString(string: "red string", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                    ]))
                let config = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                        ]
                )
                let prettyString = try? PrettyString("hello this is a {red:red string}", config: config).parse()
                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should work when used as the string extension") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "hello this is a "))
                attributedString.append(NSAttributedString(string: "red string", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                ]))
                let config = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                    ]
                )
                let prettyString = try? "hello this is a {red:red string}".prettify(config)
                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should parse a string with a few attributes") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "red fish", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                ]))
                attributedString.append(NSAttributedString(string: " "))
                attributedString.append(NSAttributedString(string: "blue fish", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.blue,
                ]))
                attributedString.append(NSAttributedString(string: " "))
                attributedString.append(NSAttributedString(string: "bold fish", attributes: [
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15),
                ]))
                attributedString.append(NSAttributedString(string: " gold fish"))

                let config = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                        PrettyString.Config.Rule(
                            name: "blue",
                            attributes: [.foregroundColor(UIColor.blue)]
                        ),
                        PrettyString.Config.Rule(
                            name: "bold",
                            attributes: [.font(UIFont.boldSystemFont(ofSize: 15))]
                        ),
                    ]
                )
                let prettyString = try? PrettyString("{red:red fish} {blue:blue fish} {bold:bold fish} gold fish", config: config).parse()

                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should parse a string with nested attributes") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "red and ", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                    ]))
                attributedString.append(NSAttributedString(string: "bold", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red,
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15),
                    ]))
                attributedString.append(NSAttributedString(string: "!"))

                let config = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                        PrettyString.Config.Rule(
                            name: "bold",
                            attributes: [.font(UIFont.boldSystemFont(ofSize: 15))]
                        ),
                        ]
                )
                let prettyString = try? PrettyString("{red:red and {bold:bold}}!", config: config).parse()

                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should override nested attributes correctly") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "red and ", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                    ]))
                attributedString.append(NSAttributedString(string: "blue but bold", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.blue,
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15),
                    ]))
                attributedString.append(NSAttributedString(string: "!"))

                let config = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                        PrettyString.Config.Rule(
                            name: "blue-bold",
                            attributes: [
                                .foregroundColor(UIColor.blue),
                                .font(UIFont.boldSystemFont(ofSize: 15)),
                            ]
                        ),
                        ]
                )
                let prettyString = try? PrettyString("{red:red and {blue-bold:blue but bold}}!", config: config).parse()

                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should use the base attributes on the whole string") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "hello this is a ", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.green
                ]))
                attributedString.append(NSAttributedString(string: "red string", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                ]))
                let config = PrettyString.Config(
                    base: [
                        .foregroundColor(UIColor.green),
                    ],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                    ]
                )
                let prettyString = try? PrettyString("hello this is a {red:red string}", config: config).parse()
                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should escape the open and close characters correctly") {
                let attributedString = NSAttributedString(string: "{bold:hello} this is a string")
                let prettyString = try? PrettyString("{{bold:hello{} this is a string").parse()
                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true
            }

            it("should throw an error when the name is not defined") {
                expect(try? PrettyString("{bold:hello} this is a string").parse()).to(beNil())
            }

            it("should throw an error when there is no name") {
                expect(try? PrettyString("{:hello} this is a string").parse()).to(beNil())
            }

            it("should throw an error with mismatched open and closes") {
                let config = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "bold",
                            attributes: [.font(UIFont.boldSystemFont(ofSize: 15))]
                        ),
                        ]
                )
                expect(try? PrettyString("{bold:hello this is a string", config: config).parse()).to(beNil())
                expect(try? PrettyString("bold:hello} this is a string", config: config).parse()).to(beNil())
            }

            it("should use the default config with nothign specified") {
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: "hello this is a "))
                attributedString.append(NSAttributedString(string: "red string", attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red
                ]))
                PrettyString.Config.default = PrettyString.Config(
                    base: [],
                    rules: [
                        PrettyString.Config.Rule(
                            name: "red",
                            attributes: [.foregroundColor(UIColor.red)]
                        ),
                        ]
                )
                let prettyString = try? PrettyString("hello this is a {red:red string}").parse()
                expect(prettyString.map { $0.isEqual(to: attributedString) }) == true 
            }
        }
    }
}
