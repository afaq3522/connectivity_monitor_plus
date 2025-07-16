This Flutter package provides a seamless way to monitor internet connectivity within your application. 
It automatically detects changes in the network status and displays a customizable dialog 
to inform the user about the connection loss or restoration. 
This is essential for applications that rely on a stable internet connection 
to function correctly, ensuring a better user experience by providing timely feedback.


## Features
* Monitors internet connectivity in real-time.
* Displays a non-intrusive dialog when the internet connection is lost.
* Automatically dismisses the dialog when the internet connection is restored.
* Customizable dialog content and appearance to match your app's theme.
* Easy to integrate into any Flutter project.

## Getting started

1. Add the package to your `pubspec.yaml` file:
2. Install the package:
3. Wrap your first existing screen in stack with `ConnectivityWrapper`:


## Usage

routes: {
// When navigating to the "/" route, build the FirstScreen widget.
'/': (context) => ConnectivityWrapper(child: MyHomePage(title: 'Connectivity Monitor',)),
// When navigating to the "/second" route, build the SecondScreen widget.
},



## Additional information
More details about the package are provided in `package description section`.

