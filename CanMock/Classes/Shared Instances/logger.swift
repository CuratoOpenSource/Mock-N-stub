import InjectableLoggers


/// The settings that will be used by `logger`
/// The changes to these settings will only have effect when done before the first `logger` calls have been made
public var loggerSettings = Logger.Settings(activeLogLevel: .warning,
                                            defaultLogLevel: .verbose,
                                            loglevelStrings: [.verbose: "🔍", .info: "ℹ️", .warning: "\n⚠️", .error:"\n⛔️"])

internal let logger = Logger(settings: loggerSettings)
internal typealias Loglevel = InjectableLoggers.Loglevel
