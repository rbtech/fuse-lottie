# Fuse-Lottie

## Install

1. Add this source as a project of your fuse project e.g. `MyApp/Projects/Fuse-Lottie`.
2. Add the following lines to your .unoproj, taking into account your project directory.
```json
  "Projects": [
    "Projects/Fuse-Cocoapods/cocoapods_include.unoproj",
    "Projects/Fuse-Lottie/Lottie.unoproj"
  ]
```

## Usage
1. Copy your .json animations into a folder such as `MyApp/Assets/Animations`
2. Add the following to your .unoproj to bundle the animations
```json
"Includes": [
  "Assets/Animations/*.json:Bundle"
]
```
3. Add the component to your UX markup (note: it will work on the device)
```xml
<NativeViewHost Width="100%" Height="320">
	<RBT.Animation.Lottie ux:Name="myPlayer" File="{urlToJSON}" ContentMode="{contentMode}" LoopAnimation="{loopAnimation}" Play="{play}" Pause="{pause}" Stop="{stop}" Progress="{progress}" AutoReverseAnimation="{autoReverseAnimation}" AnimationCompleted="{animationCompleted}" />
</NativeViewHost>
```

See [Full Example App](https://github.com/rbtech/fuse-lottie-app) for available options.


## Some Lottie Animation Notes
* We're currently using Lottie version 2.5.3
* Draw everything; can't use images for Android.
* Checkout the list of supported features: [https://github.com/airbnb/lottie-ios#supported-after-effects-features](https://github.com/airbnb/lottie-ios#supported-after-effects-features)
* Go through the After Effects/SVG tips here: [http://airbnb.io/lottie/#/after-effects](http://airbnb.io/lottie/#/after-effects)