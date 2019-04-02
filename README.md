# Navigation

- Simplifies UIViewController instantiation using only the controller's StoryboardID. 
- Check the existence of a UIViewController in the project thanks to its StoryboardID

## Installation

Import Navigation.swift in your project (or use example project)

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

Return all storyboard name 

```Swift
Navigation.getAllStoryboardName()
```
Return all UIViewController name 

```Swift
Navigation.getAllViewControllerName()
```
Return all UIViewController name for specific Storyboard

```Swift
Navigation.getAllViewController(inStoryboard: "Main")
```

