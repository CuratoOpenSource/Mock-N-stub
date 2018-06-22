extension Dictionary: ProvidingDefaultStubValue {

    public static func defaultStubValue() -> Dictionary<Key, Value> {
        return [Key: Value]()
    }
}
