# 📍 PinPoint Location App

An iOS app built using Swift, UIKit, and MVVM architecture.
Users can add pinpoints on the map with a title and description by long-pressing.
The app saves pinpoints locally using UserDefaults and shows them both in a list and on a map.

✨ Features
Show user's current location on the map

Add pinpoints with title and description by long-press gesture

List all saved pinpoints in a table view

Tap on map annotations to view pinpoint details

Delete pinpoints from the list

Persist all pinpoints using UserDefaults

MVVM architecture for clean separation of logic

Reusable UIAlertController extension for cleaner code

🛠 Technologies Used
UIKit

MapKit

CoreLocation

UserDefaults (for local persistence)

MVVM Architecture

Swift 5

🏗 Project Structure
plaintext
Copy
Edit
├── ViewControllers
│   └── LocationDetailsVC.swift
├── ViewModels
│   └── PinPointViewModel.swift
├── Models
│   └── PinPoint.swift
├── Extensions
│   └── UIAlertController+Extension.swift
├── Views
│   └── PinPointTVC.swift
├── Utilities
│   └── (Optional) AppUserDefaults.swift
⚡ How to Run the Project
Open the project in Xcode.

Make sure you add the following permissions in Info.plist:

xml
Copy
Edit
<key>NSLocationWhenInUseUsageDescription</key>
<string>App needs your location to show on the map and add pinpoints.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>App needs your location to show on the map and add pinpoints.</string>
Build and run the app on a real device or simulator.

📌 Notes
All added pinpoints are saved locally using UserDefaults, even after app is closed and reopened.

Pinpoints are encoded/decoded using Codable protocol.

UIAlertController extension is used to simplify alerts.

🚀 Future Improvements
Add editing functionality to pinpoints

Sync pinpoints to iCloud for backup

Search functionality for pinpoints

Custom annotations with images/icons

👨‍💻 Author
Developed by Faseeh PM 🚀

