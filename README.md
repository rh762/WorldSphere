# WorldSphere

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)

## Table of Contents

- [Description](#description)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Setup](#setup)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)


## Description

WorldSphere is a web application that displays the current time for various time zones around the world. It provides users with an intuitive interface to view multiple time zones simultaneously in a responsive grid layout. The app features a dark mode toggle for improved user experience and a footer with additional information. WorldSphere is an ideal tool for global teams, travelers, and anyone working across multiple time zones.

## Features

- Display current time for multiple time zones
- Responsive grid layout for easy viewing on various devices
- Dark mode toggle for improved readability in different lighting conditions
- Real-time updates of displayed times without page reload
- Day/night indicators for each time zone
- Country flags for easy identification
- Persistent dark mode preference using local storage


## Technologies Used

- Backend: Java Servlets
- Frontend: JSP (JavaServer Pages), HTML, CSS, JavaScript
- Build Tool: Maven
- JSON Processing: Google Gson library
- Styling: Custom CSS with variables for theming
- Font: Google Fonts (Montserrat)


## Setup

1. Ensure you have Java JDK 8 or higher installed
2. Install Maven on your system
3. Clone the repository:

```plaintext
git clone https://github.com/yourusername/WorldSphere.git
```


4. Navigate to the project directory:

```plaintext
cd WorldSphere
```


5. Build the project using Maven:

```plaintext
mvn clean install
```


6. Deploy the generated WAR file to a servlet container like Tomcat


## Usage

1. After deploying the application, open a web browser and navigate to the appropriate URL (e.g., `http://localhost:8080/WorldSphere`)
2. The main page will display a grid of time cards for various cities around the world
3. Each card shows the city name, current time, country flag, and a day/night indicator
4. Use the dark mode toggle in the top right corner to switch between light and dark themes
5. The times update automatically every second without needing to refresh the page


## Project Structure

```plaintext
WorldSphere/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── worldsphere/
│   │   │           ├── TimeZoneServlet.java
│   │   │           └── WorldTimeServlet.java
│   │   ├── webapp/
│   │   │   ├── WEB-INF/
│   │   │   │   └── web.xml
│   │   │   └── index.jsp
│   │   └── resources/
├── pom.xml
└── README.md
```

## Contributing

Contributions to WorldSphere are welcome! Please follow these steps to contribute:

1. Fork the repository
2. Create a new branch: `git checkout -b feature-branch-name`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature-branch-name`
5. Submit a pull request


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

This README provides a comprehensive overview of the WorldSphere project, including its features, setup instructions, usage guidelines, and contribution information. It should give users and developers a clear understanding of the project and how to work with it.
