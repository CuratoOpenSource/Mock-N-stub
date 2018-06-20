public protocol ProvidingDefaultStubValue {
    
    /// The value that will be provided by `Stubbing` when no other value has been provided using `given..`
    ///
    /// In case a value has been provided, this value won't be used
    static var defaultStubValue: Self { get }
}
