WeatherHype
=
WeatherHype is a simple weather app built using the
[openweathermap.org](http://openweathermap.org) weather API.

WeatherHype is a universal app for devices running iOS 9.3 or higher.


Build, test and run
=
WeatherHype is implemented is Swift 3 and therefore requires Xcode 8.0 to run.

Open the `WeatherHype.xcworkspace`in Xcode and hit:

* `CMD+U`  to build & run the tests
* `CMD+R`  to build & run the app

Technical Notes
=

By default the app displays weather forecasts for London. 

To change the default city edit the config file `WeartherHype/Resources/Config.plist` and update the value of the `DefaultCity` property.

The app uses CocoaPods for dependency management and depends on two 3rd party libraries:

*  `SwiftyJSON` for sane JSON parsing
*  `NVActivityIndicatorView` to display pretty activity indicators during network operations.

Technical Improvements
=

This initial implementation needs to be improved in the following areas:

* Error handling: network requests should handle error conditions (e.g network errors, timeouts, API errors) and display an appropriate message to the user.
* Improve Test coverage: include unit tests for the data model and data transformers. Add UI tests for end-to-end user interactions
* Offline support: add some support for lack of connectivity and inform the user if the data of stale data.

Feature Improvemens
=

There are many things I'd like to improve given more time, including:

* Ability to search for forecasts of different cities 
* Manage a list of cities previously viewed.
* Use GeoLocation to show forecasts for the city where the user is.
* High resolution and high quality images for different weather states (I used low res images avaiable on openweathermap as placeholders.)
* High quality app icons (I used a simple png, upscaled to all correct sizes using [makeappicon.com](https://makeappicon.com))
* Localisation: translated strings and localised formats.
* Allow the user to switch between metric and imperial units.
* Automatically refresh the weather data when the app becomes active.
* Improvements to the visual design.


	
        



