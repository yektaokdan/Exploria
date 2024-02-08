# Exploria

Exploria transforms outdoor adventures into a shared journey of discovery, enabling users to pinpoint locations on a map, photograph plants, waterfalls, and other elements of nature, and save these discoveries with detailed annotations. It is the perfect companion for anyone passionate about exploring and documenting the natural world.

## Overview

Exploria allows users to enrich their outdoor adventures with the ability to save the geographical location, photos, names, descriptions, and dates of their natural discoveries. This application makes every journey into the wild a part of a personalized digital journal, ready to be revisited and shared at any moment.

## Features

- **Pinpoint and Save Locations:** Users can capture and store photos of nature's wonders, accompanied by detailed annotations.
- **Browse Saved Locations:** A list of saved locations can be viewed on the map, enriched with names, descriptions, and discovery dates.
- **Map Integration:** Utilizes CoreData for efficient data storage, ensuring all discoveries are securely saved.
- **Navigation Support:** Offers seamless navigation to any selected discovery with a simple tap.
- **User-friendly Interface:** Features gesture recognizers and a Navigation Controller for intuitive browsing and discovery addition.

## Installation

### Prerequisites

- macOS with the latest version of Xcode installed.
- An iOS device or simulator with iOS 13.0 or later.
- Basic knowledge of Swift and Xcode for project setup.

### Getting Started

1. **Clone the Repository**: First, clone the repo to your local machine using Git:

    ```bash
    git clone https://github.com/yourusername/Exploria.git
    ```

2. **Open the Project in Xcode**: Navigate to the cloned directory and open the `Exploria.xcodeproj` file in Xcode.

    ```bash
    cd Exploria
    open Exploria.xcodeproj
    ```

3. **Install Dependencies**: If the project uses external libraries, install them by running the following command in the Terminal (if using CocoaPods):

    ```bash
    pod install
    ```

    Then, open the `.xcworkspace` file to ensure all dependencies are properly linked.

4. **Configure the Project**: Make sure to configure your project with a valid development team in Xcode's project editor to enable device testing.

5. **Run the App**: Select your target device from the toolbar and hit the Run button or `Cmd + R` to build and run the application.

## Technologies Used

- **CoreData** for local data storage.
- **CoreLocation** and **MapKit** for location and map integration.
- **Gesture Recognizer** for interactive user experience.
- **Segue** for fluid navigation between app views.

Explore, capture, and reminisce about your natural discoveries with Exploria, making every outdoor adventure a memorable journey.

