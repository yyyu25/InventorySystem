# Inventory Management System

Inventory Management System is a lightweight web application built with Ruby using the Sinatra framework and SQLite3.  
It supports basic inventory tracking with user authentication, item quantity management, and batch operations.

This project was created to practice building a simple CRUD-based web application with a minimal backend framework and relational database.

---

## Project Overview

The application allows authenticated users to manage inventory items by creating, updating, and deleting records.  
It focuses on simplicity and clarity while demonstrating core web development concepts such as routing, persistence, and server-rendered views.

---

## Key Features

### User Authentication
- Login required to access inventory data
- Session-based authentication

### Inventory Management
- Add new inventory items with quantity and unit
- Edit existing items
- Delete items individually or in batches
- Update item quantities in real time

### User Interface
- Server-rendered HTML views using ERB
- Simple layout with inline CSS
- Clean and minimal UI focused on usability

---

## Tech Stack

Backend Framework: Sinatra  
Language: Ruby  
Database: SQLite3  
ORM: ActiveRecord  
Views: ERB  
Server: Puma  

---

## Application Design

The application follows a simple MVC-style structure:

- Routes handle incoming requests and control application flow
- Models manage inventory data and database interactions
- Views render dynamic HTML pages using ERB templates

This design keeps the codebase small and easy to understand while remaining extensible.

---

## Getting Started

### Clone the Repository
git clone https://github.com/yyyu25/InventorySystem.git  
cd InventorySystem

### Install Dependencies
gem install bundler  
bundle install

### Set Up the Database
bundle exec rake db:create  
bundle exec rake db:migrate

### Start the Server
bundle exec puma

Open your browser at:  
http://localhost:9292

---

## Example Functionality

- Create inventory items with quantity and unit
- Update quantities as stock changes
- Remove obsolete items
- Perform batch operations on multiple records

---

## Not Included

- No JSON API endpoints
- No automated test suite
- No frontend framework

---

## Learning Outcomes

This project helped reinforce understanding of:
- Building web applications with Sinatra
- Using ActiveRecord with SQLite
- Implementing authentication with sessions
- Designing simple CRUD workflows
- Structuring a small, maintainable codebase

---

## Possible Improvements

Future enhancements could include:
- Adding automated tests
- Improving UI styling
- Introducing role-based permissions
- Migrating to PostgreSQL

---

## License

MIT License

---

## Contact

Created by yyyu25  
GitHub: https://github.com/yyyu25
