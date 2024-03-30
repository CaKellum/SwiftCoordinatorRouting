import Foundation

/// Delegate for the router
public protocol RouterDelegate: AnyObject {
    
    /// Delegate function that indicates what path is about to be routed
    /// - Parameter path: the path that is being routed to
    func willRoute(to path: String)
    
    /// Delegate function that fires after the route has been routed to
    /// - Parameter path: the path that is being routed to
    func didRoute(to path: String)
    
    /// Delegate functon that indicates failure to find path
    /// - Parameter path: path that routing was attempted opun
    func failedToRoute(to path: String)

    /// Delegate function that fires if route fails precondition
    /// - Parameters:
    ///   - preconditionID: the precondition ID that was failed
    ///   - path: path that failed the precondition
    func failedPreconditon(_ preconditionID: String, for path: String)
}

/// This is a global coordinator that will facilitate navigation in an iOS app
public class Router {
    
    /// the global Router Instance to limit passing of a router across the app
    private(set) public static var instance: Router?

    private var registeredRoutes = [String: Route]()
    private var registeredPreconditions = [String: Precondition]()

    /// delegate to allow for some customized functionality
    private(set) public weak var delegate: (any RouterDelegate)?

    
    /// initializes Router and its shared instance
    ///
    ///  Only ever initialize this once as early in the apps lifecycle for best performance
    public init() {
        Self.instance = self
    }


    /// when provided a route that exists this will execute that routes assignd operation
    /// this operation can be any thing
    /// - Parameter path: The desired route that needs to be routed to perform functions
    /// - Returns: If the route was successfully routed to then this retruns true, false otherwise
    @discardableResult
    public func route(to path: String) -> Bool {
        let basePath = path.removeQueryParams() ?? ""
        guard let route = registeredRoutes[basePath] else {
            delegate?.failedToRoute(to: path)
            return false
        }

        guard resolvePreconditions(for: route, with: path.getQueryParams()) else { return false }

        delegate?.willRoute(to: path)
        route.operation(basePath, path.getQueryParams())
        delegate?.didRoute(to: path)
        return true
    }

    
    /// This function resolves the preconditions and will route to the precondition route if the precondition is failed
    /// - Parameters:
    ///   - route: the Route object that has the precondition
    ///   - params: the parameters that came with the route
    /// - Returns: if the route passed the precondition it will return true, false otherwise
    private func resolvePreconditions(for route: Route, with params: [String : String]) -> Bool {
        let navigatedRoute = route.path.addQueryParams(params: params).orEmpty
        let routePreconditionActions = registeredPreconditions.filter { (key, _) in
            route.preconditions.contains(where: {$0 == key})
        }
        for (key, precondition) in routePreconditionActions {
            let newRoute = precondition.action(navigatedRoute)
            if navigatedRoute.removeQueryParams() != route.path {
                self.route(to: newRoute)
                delegate?.failedPreconditon(key, for: navigatedRoute)
                return false
            }
        }
        return true
    }
    
    /// registers the route in the router so it is aware it exists
    /// - Parameter registeringRoute: the route to be registered
    public func register(_ registeringRoute: Route) {
        registeredRoutes[registeringRoute.path] = registeringRoute
    }
    
    /// registers a precondition so the route can be aware of it
    /// - Parameter precondition: THe Precondition to be registered
    public func registerPrecondition(_ precondition: Precondition) {
        registeredPreconditions[precondition.preconditionID] = precondition
    }
    
    /// this will asks if the router has a route
    /// - Parameter path: the path you are looking for
    /// - Returns: true if router has rotue, false otherwise
    public func hasRoute(path: String) -> Bool {
        registeredRoutes[path.removeQueryParams() ?? ""] != nil
    }
    
    /// remove a route form the router
    /// - Parameter route: the route's path to be removed
    public func unregister(route: String) {
        registeredRoutes.removeValue(forKey: route)
    }
    
    /// remove a route form the router, this is a wrapper for ``unregister(route:)-5vkjw``
    /// - Parameter route: the route to be removed
    public func unregister(route: Route) {
        unregister(route: route.path)
    }
    
    /// Adds many rotues ot the routere at once, convinece wrapper to the ``register(_:)`` funcition
    /// - Parameter routes: an array of routes to be added
    public func massAdd(routes: [Route]) {
        routes.forEach({self.register($0)})
    }
    
    /// Remove all routes that have the included paths, convinece wrapper to ``unregister(route:)-5vkjw``
    /// - Parameter routes:an array of route paths to be remove from the router
    public func massRemove(routes: [String]) {
        routes.forEach({self.unregister(route: $0)})
    }
    
    /// Remove all routes that have the included in the array, convinece wrapper to ``unregister(route:)-1aq12``
    /// - Parameter routes:an array of routes to be removed, from the router
    public func massRemove(routes: [Route]) {
        routes.forEach({self.unregister(route:$0)})
    }
}
