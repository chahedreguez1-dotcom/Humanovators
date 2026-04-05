# Humanovators
# MediDrone Ops — Dashboard

A real-time medical drone operations dashboard for Greater Tunis, built with HTML/CSS/JS and ROS integration.

## Overview

MediDrone Ops is a web-based control center for managing a fleet of medical delivery drones across Tunis. It displays live drone positions, mission status, battery levels, and incoming delivery requests — all connected to a ROS (Robot Operating System) backend.

## Features

- **Live fleet map** — animated drone routes across Tunis (C. Nicolle, Thameur, La Marsa, Ariana, Carthage)
- **Real-time KPIs** — active drones, urgent requests, deliveries today, success rate
- **Mission tracking** — per-drone mission status (urgent / transit / done)
- **Battery monitoring** — live battery bar per drone with color-coded alerts
- **Incoming requests** — dispatch drones manually or use auto-dispatch
- **Activity log** — live feed of events (deliveries, alerts, ROS messages)
- **ROS integration** — connects to a ROS bridge via WebSocket (`ws://localhost:9090`)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML5, CSS3, Vanilla JS |
| ROS bridge | [roslibjs](https://github.com/RobotWebTools/roslibjs) |
| Map | SVG (custom, no external map library) |
| Hosting | GitHub Pages / any static server |

## ROS Topics

| Topic | Type | Description |
|-------|------|-------------|
| `/drone/battery` | `sensor_msgs/BatteryState` | Battery percentage per drone |
| `/mission/status` | `std_msgs/String` | Mission status updates |
| `/dispatch_drone` | `std_srvs/Trigger` | Service to dispatch a drone |

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/medidrone-ops.git
cd medidrone-ops
```

### 2. Open the dashboard

Simply open `dashboard.html` in a browser:

```bash
# On Windows
start dashboard.html

# On Mac
open dashboard.html

# Or serve it locally
npx serve .
```

### 3. Connect to ROS (optional)

Make sure your ROS bridge is running:

```bash
roslaunch rosbridge_server rosbridge_websocket.launch
```

The dashboard will auto-connect to `ws://localhost:9090`. If no ROS bridge is available, the dashboard still works in demo mode with simulated data.

## Project Structure

```
medidrone-ops/
│
├── dashboard.html      # Main dashboard (single-file app)
└── README.md           # This file
```

## Screenshots

> Fleet map with live drone animations, mission panel, battery levels, and dispatch queue.

## Roadmap

- [ ] Weather integration (wind, visibility) for drone flight authorization
- [ ] AI module for automatic go/no-go flight decision
- [ ] Mobile app (Flutter) connected to the same ROS backend
- [ ] Authentication for operators
- [ ] Historical delivery analytics

## License

MIT
# MediRoute — Flutter App

A mobile application for real-time medical drone delivery management in Greater Tunis, built with Flutter.

## Overview

MediRoute connects patients and medical staff to an autonomous drone fleet for urgent medicine and medical supply delivery. Patients can request emergency medications in seconds, while hospital staff can dispatch drones to transfer blood, organs, and rare equipment between facilities.

## Screenshots

| Splash | Onboarding | Patient Home | Tracking |
|--------|-----------|--------------|---------|
| ✚ MediRoute | 3-slide intro | Emergency button | Live drone map |

## Features

### Patient side
- One-tap emergency request (insulin, cardiac meds, first aid, etc.)
- Real-time drone tracking with animated map and ETA
- Medical profile (blood type, allergies, weight)
- Delivery history
- Reception confirmation with star rating

### Staff / Hospital side
- Fleet status dashboard (available / in flight / charging)
- New request form with resource type, quantity, and urgency level
- Auto-suggested nearest source hospital
- Live mission tracking per drone
- Delivery report on confirmation

### General
- Splash screen with animation
- 3-slide onboarding
- Login / Register with Patient / Medical Staff toggle
- ROS-ready architecture (drone backend integration)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x |
| Language | Dart |
| State management | setState (local) |
| Navigation | Navigator 2.0 (push/pop) |
| UI | Material 3 |
| Animations | AnimationController, AnimatedContainer |
| Backend (planned) | ROS bridge + REST API |

## Project Structure

```
lib/
│
├── main.dart                  # Entry point + all screens (monolithic)
│
│   ├── MediRouteApp           # MaterialApp root
│   ├── SplashScreen           # Animated logo screen (3s)
│   ├── OnboardingScreen       # 3-slide PageView intro
│   ├── LoginScreen            # Login / Register — Patient or Staff
│   │
│   ├── PatientHomeScreen      # Patient dashboard + emergency button
│   ├── EmergencySelectScreen  # Medicine category selector
│   ├── DeliveryTrackingScreen # Animated drone map + status stepper
│   ├── ConfirmationScreen     # Reception confirmation + rating
│   │
│   ├── StaffHomeScreen        # Hospital staff dashboard
│   ├── StaffRequestScreen     # New medical resource request form
│   │
│   └── _buildBottomNav()      # Shared bottom navigation bar
```

## Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Android Studio or VS Code with Flutter extension

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/mediroute-app.git
cd mediroute-app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Build for production

```bash
# Android APK
flutter build apk --release

# iOS (Mac only)
flutter build ios --release
```

## App Flow

```
Splash → Onboarding → Login
                          ├── Patient  → Home → Emergency → Tracking → Confirmation
                          └── Staff    → Home → New Request → Tracking → Confirmation
```

## Roadmap

- [ ] Connect to real ROS drone backend via WebSocket
- [ ] Weather AI module — auto block flight if conditions unsafe
- [ ] Real GPS location for drone tracking (Google Maps / OpenStreetMap)
- [ ] Push notifications for delivery updates
- [ ] Authentication (Firebase / custom API)
- [ ] Multi-language support (Arabic, French, English)
- [ ] Dark mode

## Related Projects

- [MediDrone Ops Dashboard](https://github.com/your-username/medidrone-ops) — Web-based operator control center (HTML/JS/ROS)

## License

MIT

