<%@ page import="java.time.ZonedDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WorldSphere</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <style>
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
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            flex-grow: 1;
        }
        h1 {
            text-align: center;
            margin-bottom: 40px;
        }
        .clock-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
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
        .clock-card.day {
            background: var(--day-gradient);
        }
        .clock-card.night {
            background: var(--night-gradient);
        }
        .city-name {
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        .time {
            font-size: 2em;
            font-weight: bold;
            color: var(--card-text);
            margin: 10px 0;
        }
        .flag {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .day-night {
            font-size: 1.5em;
        }
        .mode-toggle {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        .mode-toggle label {
            width: 60px;
            height: 34px;
            background-color: #ccc;
            border-radius: 34px;
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: background-color 0.3s;
        }
        .mode-toggle label::after {
            content: '🌞';
            width: 26px;
            height: 26px;
            background-color: white;
            border-radius: 50%;
            position: absolute;
            top: 4px;
            left: 4px;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }
        .mode-toggle input:checked + label {
            background-color: #3a3a3a;
        }
        .mode-toggle input:checked + label::after {
            left: 30px;
            content: '🌙';
        }
        .mode-toggle input {
            display: none;
        }
        footer {
            background-color: var(--footer-bg);
            color: var(--footer-text);
            text-align: center;
            padding: 20px;
            margin-top: 40px;
        }
        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .footer-links a {
            color: var(--footer-text);
            text-decoration: none;
            margin: 0 10px;
        }
        .footer-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="mode-toggle">
        <input type="checkbox" id="darkmode-toggle">
        <label for="darkmode-toggle"></label>
    </div>
    <h1>WorldSphere</h1>
    <div class="clock-grid">
        <%
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

            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

            for (String[] city : cities) {
                ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.of(city[1]));
                int hour = zonedDateTime.getHour();
                boolean isDaytime = hour >= 6 && hour < 18;
                String timeString = zonedDateTime.format(timeFormatter);
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
<script>
    // Dark mode toggle functionality
    const darkModeToggle = document.getElementById('darkmode-toggle');
    const body = document.body;

    // Check for saved dark mode preference
    if (localStorage.getItem('darkMode') === 'enabled') {
        body.classList.add('dark-mode');
        darkModeToggle.checked = true;
    }

    darkModeToggle.addEventListener('change', () => {
        if (darkModeToggle.checked) {
            body.classList.add('dark-mode');
            localStorage.setItem('darkMode', 'enabled');
        } else {
            body.classList.remove('dark-mode');
            localStorage.setItem('darkMode', null);
        }
    });

    // Function to update times
    function updateTimes() {
        const timeElements = document.querySelectorAll('.time');
        const dayNightElements = document.querySelectorAll('.day-night');
        const clockCards = document.querySelectorAll('.clock-card');

        timeElements.forEach((element, index) => {
            const timezone = element.getAttribute('data-timezone');
            const now = new Date().toLocaleString('en-US', { timeZone: timezone, hour12: false });
            const time = now.split(', ')[1];
            element.textContent = time;

            const hour = parseInt(time.split(':')[0]);
            const isDaytime = hour >= 6 && hour < 18;
            dayNightElements[index].textContent = isDaytime ? '☀️' : '🌙';
            clockCards[index].classList.toggle('day', isDaytime);
            clockCards[index].classList.toggle('night', !isDaytime);
        });
    }

    // Update times immediately and then every second
    updateTimes();
    setInterval(updateTimes, 1000);
</script>
</body>
</html>

