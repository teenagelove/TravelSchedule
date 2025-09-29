# Travel Schedule — Technical Specification

## 🔗 Links
[Design in Figma](https://www.figma.com/design/cQ97drl0RAec3i7vNh55Ta/Расписание)

---

### 🚀 Tech Stack & Principles

![iOS](https://img.shields.io/badge/iOS-17%2B-000000?logo=apple&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0A84FF?logo=swift&logoColor=white)
![Combine](https://img.shields.io/badge/Combine-34C759?logo=swift&logoColor=white)
![Swift Concurrency](https://img.shields.io/badge/async%2Fawait-FF9F0A?logo=swift&logoColor=white)
![OpenAPI Generator](https://img.shields.io/badge/OpenAPI_Generator-005571?logo=openapiinitiative&logoColor=white)
![OpenAPIKit](https://img.shields.io/badge/OpenAPIKit-00897B?logo=swift&logoColor=white)
![SOLID](https://img.shields.io/badge/SOLID-Principles-FF2D55?logo=abstract&logoColor=white)
![MVVM](https://img.shields.io/badge/MVVM-5856D6?logo=swift&logoColor=white)
![Conventional Commits](https://img.shields.io/badge/Conventional_Commits-FF69B4?logo=git&logoColor=white)

---

## 📖 Introduction

This document describes the technical requirements and implementation details for the mobile app **Travel Schedule**.  
The app provides transportation schedules and route information using the **Yandex.Schedule API**.

<p align="center">
  <img src="Assets/Preview.gif" alt="App Preview" width="300"/>
</p>

---

## 🎯 Goals & Objectives

The main goal is to build an **iOS app** that allows users to search and view transportation schedules across different cities and access carrier information.

**Key objectives:**
- Develop a user interface with **4 main** and **4 secondary screens**.  
- Integrate the **Yandex.Schedule API** for schedule data.  
- Implement a **stories system** with news-like content.  

---

## 📱 Application Screens

- **Start Screen**  
  - Stories panel at the top  
  - Input fields for departure ("From") and arrival ("To")  
  - **Logic & Actions**:  
    - User selects departure and arrival cities  
    - "Find" button appears only when both fields are filled  
    - Tap on story preview → open full-screen stories  

- **City Selection Screen**  
  - Search field + filtered list of cities in real-time  
  - Select a city to proceed  

- **Stations Screen**  
  - List of stations for the selected city  
  - Real-time search and selection  

- **Schedule Screen**  
  - Display available routes  
  - Filtering by transfer and departure time  

- **Route Filter Screen**  
  - Filter by departure time and transfers  

- **Carrier Info Screen**  
  - Logo, name, website, phone  
  - Direct actions: call or open website  

- **Settings Screen**  
  - Light/Dark theme  
  - User Agreement  
  - App version  
  - Info about Yandex API  

- **Stories Screen**  
  - Full-screen travel/news stories with auto-switch every 10s  
  - Indicators for progress  
  - Swipe left/right to navigate, swipe down or tap ✕ to close  

---

## 🧭 Navigation

- **Master–detail navigation** between screens  
- **Tab bar** for Home and Settings  
- **Stories** open modally  

---

## ⚙️ Non-Functional Requirements

### Technical
- Architecture: **MVVM**  
- **iOS 17+** support  
- **Swift 5.x, SwiftUI** for UI  
- **Combine** for reactive programming  
- **Swift Concurrency (async/await)** for async tasks  
- **OpenAPI Generator + OpenAPIKit** for network layer code generation  
- Apply **SOLID principles**  

### Additional
- Handle loading, error, and empty states gracefully  
- Support both **light and dark themes**  
- Store user preferences locally  
- Localized: **English & Russian**  
- Analytics integration  
- Well-documented code in **English**  

### Design
- Follow Apple **Human Interface Guidelines**  
- Intuitive UX  

### Testing
- **Unit Tests** and **UI Tests** required  
- Test on real devices with multiple iOS versions  

---

## ⏳ Roadmap

- UI Design & Implementation — **6 weeks**  
- Yandex.Schedule API Integration — **2 weeks**  
