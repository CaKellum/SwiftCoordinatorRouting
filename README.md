### SwiftRouting ###

This is a simple library that allows for a simple implementation of a coordinator pattern also can allow disconncted opeartions

### Development Enviroment and requirements ###
* Built in Xcode15
* Uses swift tools: 5.10
* only officially supports use in Sonoma, iOS & tvOS 15+
    * if you want further support it is likely to work in any context you can run swift so fork it and add the explicit support your self
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

### Contributing ###

If you see an issue you feel you can fix, fork it and make a PR:
in the PR Please include:
    * Reason for change
    * High level explainer of the changes
If I agree with the changes/reason then I will merge the PR

If you 1) experience a bug or 2) feel a need to add a feature:
    * create an issue
    * if you feel you can fix or implement the issue, do so
    * if you feel like you can't
        a) you probably can belive in your self more
        b) if you really can't or dont care enough then sooner or later I or some one else will pick it up.
        
If you have a high priority fix thata has a PR or ticket, [email me](mailto:christopherk379@gmail.com) with the ticket/PR info so I can take the appropriate action.

### License Information ###

Protected under a MIT License 
Specific Details can be found [here](LICENSE.md)

