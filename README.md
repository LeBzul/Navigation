# Navigation

- Simplifies UIViewController instantiation using only the controller StoryboardID. 
- Check the existence of a UIViewController in the project with the controller StoryboardID
- Return list name (file name) of Storyboard in project
- Return list name (StoryboardID) of UIViewController in project
- Return list id of external storyboard reference for specific Storyboard
- Return entry point for specific Storyboard

## Installation

Import Navigation.swift and Storyboard.swift in your project (or use example project)

## Usage 

Return a initialised UIViewController just with Name (Name is a StoryboardId)

```Swift
if let controller = Navigation.getViewController("MyController") {
self.navigationController?.pushViewController(controller, animated: true)
}
```

Verify if controller exist in project 

```Swift
if Navigation.controllerExist("MyController") {
print("MyController exist")
}
```

Return all storyboard name (file name)

```Swift
Navigation.getAllStoryboardName()
```
Return all UIViewController name (StoryboardID) 

```Swift
Navigation.getAllViewControllerName()
```
Return all UIViewController name (StoryboardID) for specific Storyboard

```Swift
Navigation.getAllViewController(inStoryboard: "Main")
```

Return Entry point name for specific Storyboard

```Swift
Navigation.getEntryPoint(inStoryboard: "Main")
```

Return External storyboard reference name for specific Storyboard

```Swift
Navigation.getExternalStoryboardReference(inStoryboard: "Main")
```


# License
Navigation is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
If you use it, I'll be happy to know about it.
