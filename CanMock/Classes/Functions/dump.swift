func dump<T>(_ value: T) -> String {
    var result = String()
    dump(value, to: &result)
    return result
}
