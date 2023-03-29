Map<String, String> dbCreateQuery = {
  "settings":
      "CREATE TABLE settings (id INTEGER PRIMARY KEY, settingID INTEGER, settingValue INTEGER)"
};

String readSettingsQuery = "SELECT * FROM settings";