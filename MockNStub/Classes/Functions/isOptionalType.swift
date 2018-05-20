func isOptional(_ type: Any.Type) -> Bool {
    /// I curently don't know of a better way to do this
    return String(describing: type).hasPrefix("Optional")
}
