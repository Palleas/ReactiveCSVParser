# ReactiveCSVParser

## Installation

	Simply add "Palleas/reactiveCSVParser" in your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).
	Run `carthage update`, then drop the built Framework you need in your project.

## Usage

```swift
let parser = Parser(path: "le-file.csv")
let signal = parser.parse()
```

After we've got a parser, the parse method will return a [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) signal.

### Receiving results one-by-one

The whole point of this library is to handle each line independently, so you can spread any processing out 
instead of working with potentially huge CSV files.

```swift
signal.subscribeNext({ (line) -> Void in
    println("Got line \(line)")
}, error: { (error) -> Void in
	println("Got error \(error)")
}) { () -> Void in
	println("Parsing is complete")
}
```

### Receiving all results at once

If you can't do anything until you have _all_ of the results, use the `collect`
method to retrieve a single array:

```swift
signal.collect().subscribeNext({ (lines) -> Void in
    println("Got \(countElements(lines)) lines")
}, error: { (error) -> Void in
	println("Got error \(error)")
}) { () -> Void in
	println("Parsing is complete")
}
```

## Getting the code 

You'll need [Carthage](http://github.com/Carthage/Carthage) to install the dependencies.

    $ git clone git@github.com:Palleas/ReactiveCSVParser.git
    $ carthage bootstrap

## Running the tests

	$ make test

## Limitations

For now it's a **really** naive approach first splitting the content into line based on the newline character, 
then splitting each lines into columns based on the comma character.

## License 

See [LICENSE](https://github.com/Palleas/ReactiveCSVParser/blob/master/LICENSE) file.
