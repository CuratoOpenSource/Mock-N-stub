import InjectableLoggers

/// Changes to these settings will have effect up until the point that the first loggings have been made
public var loggerSettings: Logger.Settings = .warningSettings

internal let logger = Logger(settings: loggerSettings)


