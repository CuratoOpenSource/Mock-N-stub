public func verify(_ mock: CanMock, inFile file: StaticString = #file, atLine line: UInt = #line) {
    mock.verify(at: Location(file: file, line: line))
}
