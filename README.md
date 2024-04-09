### SwiftRouting ###

This is a simple library that allows for a simple implementation of a coordinator pattern also can allow disconncted opeartions

### Examples implementing ###

In the early steps of your apps lifecycle you would likely want to assign the delegate. This will allow your app to respond to route failure and other common actions that could happen. (see Router.setDelegate(_:))

```swift
    Router.setDelegate(self)
```

Also in the early steps of your apps lifecycle, you would want to run your route & precondition registrations(Router.register(_:) & Router.registerPrecondition(_:) respectfully) this is so that the router actually functions as expected

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

### License Information ###

Protected under a MIT License 
Specific Details can be found [here](LICENSE.md)

