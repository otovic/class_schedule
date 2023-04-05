Map<String, String> dbCreateQuery = {
  "settings":
      "CREATE TABLE settings (id INTEGER PRIMARY KEY, settingID INTEGER, settingValue TEXT)"
};

String readSettingsQuery = "SELECT * FROM settings";
