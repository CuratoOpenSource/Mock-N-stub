import InjectableLoggers

internal let logger = Logger(settings: Logger.Settings(activeLogLevel: .warning,
                                                       defaultLogLevel: .verbose))
internal typealias Loglevel = InjectableLoggers.Loglevel
