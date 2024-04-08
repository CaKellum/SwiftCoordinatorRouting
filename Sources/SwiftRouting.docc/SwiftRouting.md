# ``SwiftRouting``

This Is a simple framework to assist in implemting a Coordinator pattern for your application.

## Overview

Swift Routing

### how to implement

In the early steps of your apps lifecycle you would likely want to assign the delegate. This will allow your app to respond to route failure and other common actions that could happen. (see ``Router/setDelegate(_:)``)

```swift
    Router.setDelegate(self)
```

Also in the early steps of your apps lifecycle, you would want to run your route & precondition registrations(``Router/register(_:)`` & ``Router/registerPrecondition(_:)`` respectfu) this is so that the router actually functions as expected

A basic implementation would look like this:

```swift
    // registering a precondition 
    Router.registerPrecondition(.init(preconditionID: "uniquePreconditionID",
                                      action: { path in 
        guard condition else {
            return "differentPath".addQueryParams(["callbackPath":path])
        }
        return path
    }))

    // registering a route
    Router.register(.init(path: "someUniquePath", 
                          preconditions: ["uniquePreconditionID", "anotherUniquePrecondition"], 
                          operation:{ path, params in
        // Do somthing here
    }))
```
