import Foundation

/// the Precondition Object
public struct Precondition {
    /// Callback that will return a route that needs to be fired, expected behavior it will return the path passed in if precondition is satisfied
    /// - Parameter path: This is the path that is being attempted to be routed to
    /// - Returns: Path that needs to be routed to, same as teh on passed if no changes are needed, if changes are needed this returns that path
    public typealias PreconditionAction = (_ path: String) -> String
    /// the identifier to refer to the precondition
    public let preconditionID: String
    /// call back that will handle the functionality of providing the needed route
    public let action: PreconditionAction
}
