<%@ page import="java.time.ZonedDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <!-- Meta information for responsiveness and character encoding -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorldSphere</title>

    <!-- Link to Google Fonts for styling -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">

    <!-- Inline CSS styles for the page -->
    <style>
        /* Root variables for light and dark modes */
        :root {
            --bg-color: #f0f2f5;
            --text-color: #333;
            --card-bg: white;
            --card-text: #1a1a1a;
            --card-shadow: rgba(0,0,0,0.1);
            --day-gradient: linear-gradient(135deg, #e6f3ff 0%, #ffffff 100%);
            --night-gradient: linear-gradient(135deg, #e6e6ff 0%, #ffffff 100%);
            --footer-bg: #e0e0e0;
            --footer-text: #555;
        }

        .dark-mode {
            --bg-color: #1a1a1a;
            --text-color: #f0f2f5;
            --card-bg: #2c2c2c;
            --card-text: #ffffff;
            --card-shadow: rgba(255,255,255,0.1);
            --day-gradient: linear-gradient(135deg, #4a6fa5 0%, #2c2c2c 100%);
            --night-gradient: linear-gradient(135deg, #2c3e50 0%, #2c2c2c 100%);
            --footer-bg: #2c2c2c;
            --footer-text: #a0a0a0;
        }

        /* Body styling for overall appearance */
        body {
            font-family: 'Montserrat', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: background-color 0.3s, color 0.3s;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Container for main content */
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            flex-grow: 1;
        }

        /* Title styling */
        h1 {
            text-align: center;
            margin-bottom: 40px;
        }

        /* Grid layout for clock cards */
        .clock-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Individual clock card styling */
        .clock-card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px var(--card-shadow);
            text-align: center;
            transition: transform 0.2s, background 0.3s;
        }

        .clock-card:hover {
            transform: translateY(-5px);
        }

        /* Styling for day and night modes on cards */
        .clock-card.day {
            background: var(--day-gradient);
        }

        .clock-card.night {
            background: var(--night-gradient);
        }

        /* Footer styling */
        footer {
            background-color: var(--footer-bg);
            color: var(--footer-text);
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }

        /* Footer links styling */
        .footer-links a {
            color: var(--footer-text);
            text-decoration: none;
            margin: 0 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Dark mode toggle switch -->
    <div class="mode-toggle">
        <input type="checkbox" id="darkmode-toggle">
        <label for="darkmode-toggle"></label>
    </div>

    <!-- Main title -->
    <h1>WorldSphere</h1>

    <!-- Grid layout for clocks -->
    <div class="clock-grid">
        <%
            // List of cities with their time zones and flags
            String[][] cities = {
                    {"India", "Asia/Kolkata", "🇮🇳"},
                    {"London", "Europe/London", "🇬🇧"},
                    {"New York", "America/New_York", "🇺🇸"},
                    {"Tokyo", "Asia/Tokyo", "🇯🇵"},
                    {"Sydney", "Australia/Sydney", "🇦🇺"},
                    {"Dubai", "Asia/Dubai", "🇦🇪"},
                    {"Singapore", "Asia/Singapore", "🇸🇬"},
                    {"Moscow", "Europe/Moscow", "🇷🇺"},
                    {"Paris", "Europe/Paris", "🇫🇷"}
            };

            // Formatter for displaying time
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

            // Loop through each city and render a clock card
            for (String[] city : cities) {
                ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.of(city[1])); // Get current time
                int hour = zonedDateTime.getHour();
                boolean isDaytime = hour >= 6 && hour < 18; // Determine if it is daytime
                String timeString = zonedDateTime.format(timeFormatter); // Format time
        %>
        <div class="clock-card <%= isDaytime ? "day" : "night" %>">
            <div class="flag"><%= city[2] %></div>
            <div class="city-name"><%= city[0] %></div>
            <div class="time" data-timezone="<%= city[1] %>"><%= timeString %></div>
            <div class="day-night"><%= isDaytime ? "☀️" : "🌙" %></div>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- Footer section -->
<footer>
    <div class="footer-content">
        <div class="copyright">
            &copy; 2024 WorldSphere. Created By Shahid Shekh.
        </div>
        <div class="footer-links">
            <a href="https://www.linkedin.com/in/shekh-shahid-853907294/">LinkedIn</a>
            <a href="https://github.com/rh762">GitHub</a>
        </div>
    </div>
</footer>

<!-- JavaScript for dark mode and clock updates -->
<script>
    // JavaScript for dark mode toggle and updating times
    const darkModeToggle = document.getElementById('darkmode-toggle');
    const body = document.body;

    // Check for saved dark mode preference in local storage
    if (localStorage.getItem('darkMode') === 'enabled') {
        body.classList.add('dark-mode');
        darkModeToggle.checked = true;
    }

    // Toggle dark mode on checkbox change
    darkModeToggle.addEventListener('change', () => {
        if (darkModeToggle.checked) {
            body.classList.add('dark-mode');
            localStorage.setItem('darkMode', 'enabled');
        } else {
            body.classList.remove('dark-mode');
            localStorage.setItem('darkMode', null);
        }
    });

    // Update times on clock cards
    function updateTimes() {
        const timeElements = document.querySelectorAll('.time');
        timeElements.forEach((element) => {
            const timezone = element.getAttribute('data-timezone');
            const now = new Date().toLocaleString('en-US', { timeZone: timezone, hour12: false });
            element.textContent = now.split(', ')[1]; // Update time
        });
    }

    // Initial call to update times and set interval for continuous updates
    updateTimes();
    setInterval(updateTimes, 1000);
</script>
</body>
</html>
