
# Hotel Management JSP Project

A modern hotel management system built with JSP, JDBC, and MySQL. Features include user authentication, admin dashboard, room booking, and professional UI styling.

## Features
- User registration and login
- Secure session management
- Room listing and booking
- Admin dashboard with analytics
- User and admin logout
- Responsive, professional inline CSS
- Currency displayed in Indian Rupees (₹)

## Setup Instructions
1. **Database Setup**
	- Import the provided SQL schema to create tables (`users`, `rooms`, `bookings`, `admin`).
	- Update `WEB-INF/dbconfig.jsp` with your MySQL credentials.
2. **Project Structure**
	- Place JSP files in the `jsp/` directory.
	- Place configuration files in `WEB-INF/`.
3. **Run the Project**
	- Deploy the project in Apache Tomcat.
	- Access via `http://localhost:8080/Hotel_management/jsp/login.jsp`.

## Main JSP Files
- `register.jsp` — User registration
- `login.jsp` — User login
- `user_home.jsp` — User dashboard and room listing
- `room_details.jsp` — Room details and booking
- `booking_summary.jsp` — Booking confirmation
- `admin_dashboard.jsp` — Admin analytics and user bookings
- `logout.jsp` — Admin logout
- `user_logout.jsp` — User logout

## Customization
- Update CSS in each JSP for branding.
- Add more features as needed (e.g., booking history, password reset).

## Author
Tharun Pasumarthi

---
For any issues or contributions, please open an issue or pull request on GitHub.
