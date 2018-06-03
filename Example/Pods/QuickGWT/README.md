# QuickGWT

 [![Version](http://img.shields.io/cocoapods/v/QuickGWT.svg?style=flat)](http://cocoapods.org/pods/Zoomy) [![Platform](http://img.shields.io/cocoapods/p/QuickGWT.svg?style=flat)](http://cocoapods.org/pods/Zoomy) [![License](http://img.shields.io/cocoapods/l/QuickGWT.svg?style=flat)](LICENSE)

## Example

To see the example project, run the following in your terminal:

`pod try QuickGWT `

## Setup

Just add:

```Swift
import QuickGWT
```

to the files where you'd like to use `given`, `when` and `then`.

## Usage

Considering you're already using Quick and Nimble:

```Swift
given("A viewController") {
	
    var sut: ViewController!
	
    beforeEach {
        sut = ViewController()
    }
	
    when("viewDidLoad") {

        beforeEach {
            sut.viewDidLoad()
        }

        then("title is set") {
            expect(sut.title).to(equal("Expected Title"))
        }

        then("backgroundColor is set") {
            expect(sut.view.backgroundColor).to(equal(UIColor.white))
        }
    }
}
```
The test results will look like this:
![Test results](Art/TestResults.png)

## Some background

* All this lib contains is four functions
	* You can see them [here](https://github.com/mennolovink/QuickGWT/blob/develop/QuickGWT/Classes/GivenWhenThen.swift)
		* `given` is an alternative to Quick's `describe` function
		* `when` is an alternative to Quick's `context` function
		* `and` is (also) an alternative to Quick's `context` function
		* `then` is an alternative to Quick's `it` function
* You can always mix up these added functions with Quick's existing `describe`, `context` and `it` functions

## Installation
### CocoaPods
QuickGWT is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QuickGWT'
```
You'd propably going to want this in your test target(s) only.

### Adding the code manually
Considering the meat of this lib is only one file containing 4 functions, you could also just copy over [GivenWhenThen.swift](https://github.com/mennolovink/QuickGWT/blob/develop/QuickGWT/Classes/GivenWhenThen.swift) to your project/workspace. Don't forget to make sure the file is part of your test target(s).

## Author

mennolovink, mclovink@me.com

## License

QuickGWT is available under the MIT license. See the LICENSE file for more info.
