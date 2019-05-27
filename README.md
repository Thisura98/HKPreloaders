# HKPreloaders

<p>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift5-f48041.svg?style=flat"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat"></a>
<a><img src="https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat"></a>
</p>

![Example Gif](https://github.com/Thisura98/HKPreloaders/raw/master/Pod%20-%20Example.gif)

A set of preloader animations written in Swift. The animations utilize `CAKeyframeAnimation` objects and the views for the preloaders are instantiated from the `.xib` files. The following animation classes are provided.

1. Morphing Animation - `HKMorphingPreloaderView`
2. Spinning/growing Animation - `HKSpinningPreloaderView`

## Requirements

- iOS 8.0+
- Swift 5.0

- XCODE 10.2

## Installation

### Cocoapods ###

HKPreloaders is not yet published to cocoapods, but you can still add the following to your `Podfile` to use it in your iOS project. Simply add the line and run `pod install`.

```ruby
pod 'HKPreloaders', :git => 'https://github.com/Thisura98/HKPreloaders.git'
```

## Customization

- Color of each segment

All `HKPreloader` animations inherit from `HKPreloaderViewBase`. You can modify the color of each variable setting the `mode` to `.Colors` and providing it with a `HKPreloaderColorOptions` object. Assume the following code:

```swift
class viewController: UIViewController{
    @IBOutlet weak var preloader: HKMorphinPreloader!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let options = HKPreloaderColorOptions(colors: [.purple, .cyan, .orange])
        preloader.mode = .Colors(colors: options)
        preloader.show()
    }
}
```

This changes the final color of the orbs to purple, cyan, orange and purple. 

If the color array provided contains less than 4 elements, it is cycled to fill in the rest of the elements.

- Image of each segment

_coming soon!_


## Example

### Storyobards ###

Simply create a new `UIView`, and change it's class to one of the Animation classes. Create a reference to the views on your class files. All animation classes implement the `.show()` and `.hide()` methods. Use these methods to control the visibility of the animations!

### In-code ###

__TODO: Support is currently being added for in-code initialization!__ 


## Contact

Thisura98, thisura1998@gmail.com
