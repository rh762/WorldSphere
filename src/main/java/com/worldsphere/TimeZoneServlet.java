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

@WebServlet("/api/worldtimes")
public class TimeZoneServlet extends HttpServlet {
    private List<TimeZoneInfo> timeZones;
    private Gson gson = new Gson();

    private static class TimeZoneInfo {
        String name;
        String timezone;
        String flag;
        String time;
        boolean isDaytime;

        TimeZoneInfo(String name, String timezone, String flag) {
            this.name = name;
            this.timezone = timezone;
            this.flag = flag;
        }
    }

    @Override
    public void init() throws ServletException {
        timeZones = new ArrayList<>();
        timeZones.add(new TimeZoneInfo("New York", "America/New_York", "🇺🇸"));
        timeZones.add(new TimeZoneInfo("London", "Europe/London", "🇬🇧"));
        timeZones.add(new TimeZoneInfo("Paris", "Europe/Paris", "🇫🇷"));
        timeZones.add(new TimeZoneInfo("Tokyo", "Asia/Tokyo", "🇯🇵"));
        timeZones.add(new TimeZoneInfo("Sydney", "Australia/Sydney", "🇦🇺"));
        timeZones.add(new TimeZoneInfo("Dubai", "Asia/Dubai", "🇦🇪"));
        timeZones.add(new TimeZoneInfo("Moscow", "Europe/Moscow", "🇷🇺"));
        timeZones.add(new TimeZoneInfo("Singapore", "Asia/Singapore", "🇸🇬"));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        updateTimes();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(timeZones));
    }

    private void updateTimes() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        for (TimeZoneInfo tz : timeZones) {
            ZonedDateTime now = ZonedDateTime.now(java.time.ZoneId.of(tz.timezone));
            tz.time = now.format(formatter);
            tz.isDaytime = now.getHour() >= 6 && now.getHour() < 18;
        }
    }
}

