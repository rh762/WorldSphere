package com.worldsphere;

import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet that provides world time information for different cities.
 * Accessible at the endpoint `/api/worldtimes`.
 */
@WebServlet("/api/worldtimes")
public class TimeZoneServlet extends HttpServlet {
    // List of time zone information
    private List<TimeZoneInfo> timeZones;

    // Gson instance for JSON serialization
    private Gson gson = new Gson();

    /**
     * Inner class to represent time zone information for a city.
     */
    private static class TimeZoneInfo {
        String name;     // Name of the city
        String timezone; // Timezone ID
        String flag;     // Emoji representing the country's flag
        String time;     // Current time in the timezone
        boolean isDaytime; // Boolean indicating whether it's daytime in the timezone

        // Constructor to initialize time zone info
        TimeZoneInfo(String name, String timezone, String flag) {
            this.name = name;
            this.timezone = timezone;
            this.flag = flag;
        }
    }

    /**
     * Initializes the servlet with a predefined list of cities and their time zones.
     */
    @Override
    public void init() throws ServletException {
        timeZones = new ArrayList<>();
        // Adding cities with their respective time zones and flags
        timeZones.add(new TimeZoneInfo("New York", "America/New_York", "🇺🇸"));
        timeZones.add(new TimeZoneInfo("London", "Europe/London", "🇬🇧"));
        timeZones.add(new TimeZoneInfo("Paris", "Europe/Paris", "🇫🇷"));
        timeZones.add(new TimeZoneInfo("Tokyo", "Asia/Tokyo", "🇯🇵"));
        timeZones.add(new TimeZoneInfo("Sydney", "Australia/Sydney", "🇦🇺"));
        timeZones.add(new TimeZoneInfo("Dubai", "Asia/Dubai", "🇦🇪"));
        timeZones.add(new TimeZoneInfo("Moscow", "Europe/Moscow", "🇷🇺"));
        timeZones.add(new TimeZoneInfo("Singapore", "Asia/Singapore", "🇸🇬"));
    }

    /**
     * Handles GET requests by providing JSON data of time zone information.
     * @param request  The HTTP request
     * @param response The HTTP response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Update the times and day status before sending response
        updateTimes();

        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Serialize the timeZones list to JSON and write it to the response
        response.getWriter().write(gson.toJson(timeZones));
    }

    /**
     * Updates the current time and daytime status for each city in the list.
     */
    private void updateTimes() {
        // Formatter to represent time in HH:mm:ss format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

        // Loop through each time zone and update its current time and daytime status
        for (TimeZoneInfo tz : timeZones) {
            // Get the current time in the specified time zone
            ZonedDateTime now = ZonedDateTime.now(java.time.ZoneId.of(tz.timezone));
            tz.time = now.format(formatter);
            tz.isDaytime = now.getHour() >= 6 && now.getHour() < 18; // Determine if it's daytime
        }
    }
}
