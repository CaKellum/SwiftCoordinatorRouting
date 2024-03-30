### SwiftRouting ###
This is a simple swift coordinator

## Example

this is registering a route
```swift

Router.instance.register(Route("/home") { _, parameters in
	var title = parameters["title"] ?? "home"
	UINavigationController.pushViewController(UIViewController(nibName: nil, bundle: nil))
}

```
