# ArrayPlusTuple

 [![Version](http://img.shields.io/cocoapods/v/ArrayPlusTuple.svg?style=flat)](http://cocoapods.org/pods/Zoomy) [![Platform](http://img.shields.io/cocoapods/p/ArrayPlusTuple.svg?style=flat)](http://cocoapods.org/pods/Zoomy) [![License](http://img.shields.io/cocoapods/l/ArrayPlusTuple.svg?style=flat)](LICENSE)

Simple [extension](https://github.com/mennolovink/ArrayPlusTuple/blob/develop/ArrayPlusTuple/Classes/Array%2Btuple.swift) that makes creating tuples from arrays a breeze. 

Originally created for [Mock 'N Stub](https://github.com/mennolovink/Mock-N-stub).

## Setup

Just add:

```Swift
import ArrayPlusTuple
```

to the files where you need tuples from arrays.

## Example

Non optional Any:

```Swift
let tuple = [1, 2, "tree"].tuple
```

Typed optional:

```Swift
let tuple = [1, 2, "tree"].tuple as? (Int, Int, String)
```

## Larger arrays

ArrayPlusTuple currently supports creating tuples from arrays with up to 24 elements. 

When creating tuples from arrays with more than 24 elements, a warning will be logged and a tuple with the first 24 elements of the array is still returned.

![Screenshot Missing](Art/Warning.png)

### Need support for more elements?

Create a [feature request](https://github.com/mennolovink/ArrayPlusTuple/issues/new) and it will likely be picked up.

Or [add it yourself](https://github.com/mennolovink/ArrayPlusTuple/blob/develop/ArrayPlusTuple/Classes/Array%2Btuple.swift) and create a pull request, if the tests pass i'll merge it.

## Author

mennolovink, mclovink@me.com

## License

ArrayPlusTuple is available under the MIT license. See the LICENSE file for more info.
