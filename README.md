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
