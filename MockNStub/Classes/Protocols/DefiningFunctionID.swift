public protocol DefiningFunctionID {
    
    associatedtype FunctionID: RawRepresentable where FunctionID.RawValue == String
}
