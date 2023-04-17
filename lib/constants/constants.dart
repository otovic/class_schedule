Map<String, String> dbCreateQuery = {
  "settings":
      "CREATE TABLE settings (id INTEGER PRIMARY KEY, settingID INTEGER, settingValue TEXT)",
  "schedule_settings":
      "CREATE TABLE schedule_settings (id INTEGER PRIMARY KEY, settingID INTEGER, settingValue TEXT)",
};
