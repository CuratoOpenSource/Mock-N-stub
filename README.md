# Mock 'N Stub

 [![Version](http://img.shields.io/cocoapods/v/MockNStub.svg?style=flat)](http://cocoapods.org/pods/Zoomy) [![Platform](http://img.shields.io/cocoapods/p/MockNStub.svg?style=flat)](http://cocoapods.org/pods/Zoomy) [![License](http://img.shields.io/cocoapods/l/MockNStub.svg?style=flat)](LICENSE)

Code completed Mocking and Stubbing for Swift protocols and classes.

## Example

To see the example project, run the following in your terminal:

```
pod try MockNStub
```

## Setup

Just add:

```Swift
import MockNStub
```

to the files where you need to create mocks or stubs.

## All Mocks are Stubs

All created mocks conform to the `Mocking` protocol and since `Mocking` conforms to the `Stubbing` protocol, all created mocks can automatically be used as stubs too.

Wenever you feel that an explicit stub needs to support `Mocking`, all you need to do is change it's conformance from `Stubbing` to `Mocking`. 

## Class Mocks and Protocol share the exact same interface
The implementations in MockNStub are completely protocol oriented. This allows the interface of class and protocol mocks (and stubs) to be exactly the same. All explicit stubs conform to `Stubbing` and all mocks conform to `Mocking`. There's never a need to inherit from a concrete type from this library.

## Two ways of creating fakes

We can create mocks stubs in two ways; using `@objc` **selectors** and using **functions** (or more specifically their names). While using the function names to create [stubs](###Creating-stubs) and [mocks](###Creating-mocks) is a bit faster because needed function name is known within the scope of the stub or mock, it's more error (typo) prone when using these fakes because identifying methods by their names from the outside of the fake does (currently) not currently support code completion or inference. 

Therefore identifying methods using selectors is the recommended way. However some methods can't be identified using selectors because they use swift types that can't be represented in objc. The compiler will let you know when this is the case.

When your fake inherits from NSObject in whatever way, there's no need to prefix it's methods with `@objc `, when it isn't the compiler will let you know and give helpful quick fixes.

When creating fakes (mocks or stubs) and identifying them using their function names, it can be helpful to store these names in constants. Proper support for enums with this purpose will be added soon.

When creating fakes and identifying them using their selectors, it can be helpful to leverage Xcode's code snippets to avoid having to type `#selector()` all the time. These snippets will soon be added to this repo as well.

Please note that neither the `Mocking` or `Stubbing` protocols rely on **one** way of doing this. You can mix it up whenever needed. For instance some methods in the same fake can be identified using their function names while others can be identified by their selectors.

## Stubbing
### Creating stubs
#### Using selectors
```Swift
class UITableViewDataSourceStub: Stubbing, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCallSelector(#selector(tableView(_:numberOfRowsInSection:)), withArguments: tableView, section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCallSelector(#selector(tableView(_:cellForRowAt:)), withArguments: tableView, indexPath)!
    }
}
```
Notes:

* Everything inside `#selector()` is code completed.
* [No need](###unwapping-return-value-of-didCall()) to worry about force unwrapping the optional value that's returned.

#### Using function names
```Swift
class UITableViewDataSourceStub: Stubbing, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCallFunction(withArguments: tableView, section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCallFunction(withArguments: tableView, indexPath)!
    }
}
```
Notes:

* No need to manually provide a function name.

### Adding return values to stubs
#### Using selectors
Considering:

```Swift
let stub = UITableViewDataSourceStub()
```

You can add stub values like this:

```Swift
stub.given(#selector(sut.tableView(_:numberOfRowsInSection:)), willReturn: 0)
stub.given(#selector(sut.tableView(_:cellForRowAt:)), willReturn: UITableViewCell())
```

Or when needing to be more specific, like this:

```Swift
stub.given(#selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
	return args.0 === expectedTableView && args.1 == 2
}), willReturn: 42)
```
Notes:

* Argument matcher won't match if argument types are not correct.

#### Using function names
Considering:

```Swift
let stub = UITableViewDataSourceStub()
```

You can add stub values like this:

```Swift
stub.given("tableView(_:numberOfRowsInSection:)", willReturn: 0)
stub.given("tableView(_:cellForRowAt:)", willReturn: UITableViewCell())
```

Or when needing to be more specific, like this:

```Swift
stub.given("tableView(_:numberOfRowsInSection:)"), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
	return args.0 === expectedTableView && args.1 == 2
}), willReturn: 42)
```
Notes:

* Argument matcher won't match if argument types are not correct.

## Mocking
### Creating mocks
#### Using selectors

```Swift
class UITableViewDataSourceMock: NSObject, Mocking, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCallSelector(#selector(tableView(_:numberOfRowsInSection:)), withArguments: tableView, section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCallSelector(#selector(tableView(_:cellForRowAt:)), withArguments: tableView, indexPath)!
    }
}
```
Notes:

* Every mock directly suports stubbing

#### Using function names

```Swift
class UITableViewDataSourceMock: NSObject, Mocking, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCallFunction(withArguments: tableView, section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCallFunction(withArguments: tableView, indexPath)!
    }
}
```

### Creating expectations
#### Using selectors

Considering:

```Swift
let mock = UITableViewDataSourceMock()
```

You can add expectations like this:

```Swift
mock.expect(callToSelector:  #selector(sut.tableView(_:cellForRowAt:)))
mock.expect(callToSelector:  #selector(sut.tableView(_:numberOfRowsInSection:)))
```

Or when needing to be more specific, like this:

```Swift
mock.expect(callToSelector:  #selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
	return args.0 === tableView && args.1 == 42                        
}))
```
#### Using function names

```Swift
let mock = UITableViewDataSourceMock()
```

You can add expectations like this:

```Swift
mock.expect(callToFunction: "tableView(_:cellForRowAt:)")
mock.expect(callToFunction: "tableView(_:numberOfRowsInSection:)")
```

Or when needing to be more specific, like this:

```Swift
mock.expect(callToFunction: "tableView(_:numberOfRowsInSection:)", withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
	return args.0 === tableView && args.1 == 42                        
}))
```

### Verifying

regardless of how methods have been identified:

```Swift
mock.verify()
```

Notes:

* This will result in an XCT failure when one ore more expectations have not been met.

### Properties

Mocking and stubbing properties is done like expected.

#### Using selectors

```Swift
var title: String {
    get {
        return didCallSelector(#selector(getter: self.title))!
    }
    set {
        didCallSelector(#selector(setter: title), withArguments: newValue)
    }
}
```
Notes:

* In case you forget the `getter:` or `setter:` prefix, Xcode will friendly remind you and provide a quickfix for it.
* `self.` is needed in the getter to prevent a warning. Xcode will also provide the option to fix this automatically.

#### Using function names

```Swift
var title: String {
    get {
        return didCallFunction()!
    }
    set {
        didCallFunction(withArguments: newValue)
    }
}
```

Notes:

* This get set pattern is identical on any property.

### Unwapping return value of didCall()
* Considering you're only going to use MockNStub in your test target(s), there's no need to worry about the force (!) unwrapping of the optional return values of `didCallSelector` and `didCallFunction`.
	* In the worst case scenario this would lead to a failing test which is desired behavior because it indicates that the test hasn't been setup correctly.
	* Every force unwrap of a nil value is known before it occurs and will cause detailed diagnosics to be logged to the console which shows what was expected to happen vs. what actually happened:![Screenshot Missing](Art/LogWhenForceUnwappingReturnValue.png)
* It some cases it can still be helpful to prevent a force unwrapped nil from happening by writing something like `return didCallFunction() ?? 0` instead.
	* This will have no effect on return values that have been provided using the `given..` methods.	

## Installation

MockNStub is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MockNStub'
```

## Author

mennolovink, mclovink@me.com

## License

MockNStub is available under the MIT license. See the LICENSE file for more info.
