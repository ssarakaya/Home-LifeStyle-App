# VICO Maison 🛋️✨

A premium, minimalist mobile application designed to showcase and manage luxury home decor, tableware, and interior textiles. **VICO Maison** is built entirely with Flutter and implements an offline-first architecture powered by a local relational database.

## ✨ Features

* **Premium Catalog:** Browse high-end curated home pieces across structured design categories in a fluid grid layout.
* **Inventory Management:** Insert new items dynamically with strict data-type form validation.
* **Curated Wishlist:** Save, track, and manage a persistent favorites/dowry checklist instantly.
* **100% Offline-First:** Read and write data seamlessly without requiring any internet connection.

## 🏗️ Architecture & Tech Stack

The project adheres to a strict **Layered Architecture** to keep the business logic decoupled from the presentation tier:

* **Presentation Layer:** Built with Material 3 and custom typography via Google Fonts for a luxury aesthetic.
* **State Management:** Handled by **Provider** to ensure responsive, reactive UI updates with low boilerplate.
* **Data Layer:** Structured **SQLite** database (`sqflite`) completely abstracted using individual **DAO (Data Access Object)** and **Repository** patterns.

