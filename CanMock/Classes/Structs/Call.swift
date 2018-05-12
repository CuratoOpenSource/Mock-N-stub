public struct Call {
    
    let selector: Selector
    let arguments: Any
    
    init(selector: Selector, arguments: Any) {
        self.selector = selector
        self.arguments = arguments
    }
}
