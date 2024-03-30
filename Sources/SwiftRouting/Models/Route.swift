import Foundation

/// This is the Routing object
public struct Route {
    /// the callback type that will return the path and params that are needed
    /// - Parameters:
    ///    - path: the path that is being routed to, incase it is needed
    ///    - params: the parameters that are being passed to aid in the construction of action performed by this route
    public typealias PathDispatch = (_ path: String, _ params: [String: String]) -> Void
    ///  path that is being routeed to
    public let path: String
    /// any preconditionId that shoudl be resolved prior to navigation of the main route
    public let preconditions: [String]
    /// the call back that handles the set up
    public let operation: PathDispatch

    public init(path: String, preconditions: [String] = [], operation: @escaping PathDispatch) {
        self.path = path
        self.preconditions = preconditions
        self.operation = operation
    }
}
