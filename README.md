# PrettyString

[![CI Status](https://img.shields.io/travis/OinkIguana/PrettyString.svg?style=flat)](https://travis-ci.org/OinkIguana/PrettyString)
[![Version](https://img.shields.io/cocoapods/v/PrettyString.svg?style=flat)](https://cocoapods.org/pods/PrettyString)
[![License](https://img.shields.io/cocoapods/l/PrettyString.svg?style=flat)](https://cocoapods.org/pods/PrettyString)
[![Platform](https://img.shields.io/cocoapods/p/PrettyString.svg?style=flat)](https://cocoapods.org/pods/PrettyString)

PrettyString defines a highly customizable, and extremely simple syntax for making strings pretty.

Where XML, HTML and Markdown based alternatives exist, PrettyString provides significantly more
flexibility than Markdown with a much cleaner syntax than HTML.

## Usage

PrettyString allows you to specify sections within your string which are to be styled using certain
attributes. To denote a section uses the syntax `{name:text}`, like this:

```swift
let string = "Hello this is some {blue:blue text}"
```

Here, the name is `blue`, and the text is `blue text`. What this name means, however, is entirely up
to you. There are *no* built in styles. Fortunately defining a style is very simple:

```swift
let config = PrettyString.Config(
    base: [],
    rules: [
        PrettyString.Config.Rule(
            name: "blue",
            attributes: [
                .foregroundColor(UIColor.blue)
            ]
        )
    ]
)
```

It looks a little big, but it's really very simple. The config consists of two parts: the `base`,
and some `rules`.

The base is just a list of `Attribute`s which should be applied to the entire string.

The `rules` are then a list of `Rule`s. Each rule has a name, such as `blue`, and then a list of
`Attribute`s that should be applied when this name is encountered.

Once you have a string and a `Config`, you are ready to prettify your strings!

```swift
let attributedString = string.prettify(config)
```

That's it! Now `attributedString` should show something like

>   Hello this is some <span style='color:blue'>blue text</span>

If you find yourself always using the same `Config` object, you can even set the default config so
that calling `prettify` with no arguments will use it automatically. That means, the
`attributedString` below is the same as the one above!

```swift
PrettyString.Config.default = config
let attributedString = string.prettify()
```

## The attributes

The full list of attributes is as follows:

```swift
enum Attribute {
    case attachment(NSTextAttachment)
    case backgroundColor(UIColor)
    case baselineOffset(Float)
    case expansion(Float)
    case font(UIFont)
    case foregroundColor(UIColor)
    case kern(Float)
    case ligature(Int)
    case link(URL)
    case obliqueness(Float)
    case paragraphStyle(NSParagraphStyle)
    case shadow(NSShadow)
    case strikethroughColor(UIColor)
    case strikethroughStyle(Int)
    case strokeColor(UIColor)
    case strokeWidth(Float)
    case textEffect(String)
    case underlineColor(UIColor)
    case underlineStyle(NSUnderlineStyle)
    case writingDirection([Int])
}
```

Each corresponds to the `NSAttributedStringKey` of the same name. Their usage should be pretty
straightforward.

## Advanced Usage

### Escape Characters

All the regular escape characters and unicode sequences should *just work*, but what about actually
writing the `{` or `}` character in your string? To do that, escape it with an extra `{` in front.

That is, this: `"{{he said: hello{}"` will actually give you the string `{he said: hello}` with no
attributes, rather than trying to find a rule called `he said` and applying it to `hello{`.

### Nesting

Nesting of the attributed sections works as well. The attributes from the inner-most section will
override any of the outer styles, similar to how named sections will override the base styles:

`{green-italics:hello {red-and-bold:there}}` should show "hello" in green italics and "there" in
bold red italics (assuming you named the rules well).

### Rule Names

The actual rules can have any character in them **except** for `:`, since that is used to mark the
end of the name. You can even have a rule with `{` or `}` in the name, so long as it's not the first
character. I really suggest against doing this though, and just stick to the usual letters,
underscores, and hyphens since that ends up being the most clear.

## Requirements

This project uses Swift 4, and you should too.

## Installation

PrettyString is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PrettyString', '~> 0.1.0'
```

## Author

Cameron Eldridge, cameldridge+git@gmail.com

## License

PrettyString is available under the MIT license. See the LICENSE file for more info.
