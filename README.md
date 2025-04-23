# 🏁 TriTrack – Real-Time Marathon Tracking App

**TriTrack** is a mobile application designed to manage and track participants in multi-segment races such as triathlons. The app supports two main user roles — **Race Managers** and **Time Trackers** — with a seamless, real-time experience including smart BIB input and live leaderboard functionality.

---

## 🔧 Features

- 👤 **Role-Based Access Control**
  - Separate views and permissions for **Race Manager** and **Time Tracker**

- 🏊‍♂️🚴‍♂️🏃‍♂️ **Segment Time Tracking**
  - Record and view participant times across:
    - Swimming
    - Cycling
    - Running

- 🔢 **Smart BIB Input**
  - Auto-suggestions for BIBs
  - Prevents duplicate entries at the same checkpoint
  - Fast-tap interface with real-time validation

- 📊 **Live Leaderboard**
  - Real-time ranking per segment
  - Updates dynamically as participants pass checkpoints

- 📈 **Participant Progress Dashboard**
  - Visual status across segments
  - Track current segment, completion, or violations

- 🧑‍💼 **Race Manager Dashboard**
  - Start and stop races
  - Add, update, and manage participants and time trackers

- 🗂 **Checkpoint Logs**
  - View checkpoint history
  - See detailed logs per participant

---

## ⚙️ Tech Stack

| Layer       | Tech                                 |
|-------------|--------------------------------------|
| Frontend    | Flutter                              |
| Backend     | Firebase Functions / Laravel (optional), Socket.IO (for real-time updates) |
| Database    | Firebase Cloud Firestore             |
| Auth        | Firebase Authentication              |
| Storage     | Firebase Storage (for images/files)  |
| Messaging   | Firebase Cloud Messaging (FCM)       |


---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/TriTrack.git

cd TriTrack
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app
```bash
flutter run
```
