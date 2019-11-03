# SSSSOnboarding

A lightweight and simple swifty secure solution for <b>onboarding</b> which supports both <b>Portrait and Landscape</b>


## Requirements
- iOS 11.0+
- Xcode 10.2+
- Swift 4+

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development.

Once you have your Swift package set up, adding SSSSOnboarding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/besarism/SSSSOnboarding.git", from: "0.0.2")
]
```
Or if you go `File > Swift Packages > Add Package Dependency`, and add the link:
```swift
https://github.com/besarism/SSSSOnboarding.git
```


## Usage

### Basics

```swift
class ViewController: SSSSOnboardingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        pages = [
            Page(image: "iphone", header: "iPhone", description: "The iPhone is a line of smartphones designed and marketed by Apple Inc."),
            Page(image: "versus", header: "Versus", description: "Versus, often abbreviated v., v, vs., vs, or vrs. is a Latin word meaning 'against'."),
            Page(image: "android_phone", header: "Android phone", description: "Android phone is a smartphone that runs the Android operating system.")
        ]        
    }

}
```

### More Options
```swift
class ViewController: SSSSOnboardingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        pages = [
            Page(image: "iphone", header: "iPhone", description: "The iPhone is a line of smartphones designed and marketed by Apple Inc."),
            Page(image: "versus", header: "Versus", description: "Versus, often abbreviated v., v, vs., vs, or vrs. is a Latin word meaning 'against'."),
            Page(image: "android_phone", header: "Android phone", description: "Android phone is a smartphone that runs the Android operating system.")
        ]

        //customization
        themeColor = .systemBlue
        fontName = "HelveticaNeue"
        isLeftButtonHidden = true
        isRightButtonHidden = false
        rightButtonTitle = "Close"
        prevButtonTitle = "PREV"
        isActionButtonHidden = false
        actionButtonTitle = "Start the test"        
    }

    override func handleRightButton() {
        //do something
    }

    override func handleActionButton() {
        //do something
    }

}
```


## Results

### Portrait
![SSSSOnboarding Portrait](https://media.giphy.com/media/H7qHUf4KH3rUPpUAK1/giphy.gif)

### Landscape

![SSSSOnboarding Landscape](https://media.giphy.com/media/YMjDuNVgjVJBamGolQ/giphy.gif)

## Authors

* **Besar Ismaili** - *Initial work* - [@besarism](https://github.com/besarism)

See also the list of [contributors](https://github.com/besarism/SSSSOnboarding/graphs/contributors) who participated in this project.
