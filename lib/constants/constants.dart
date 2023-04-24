Map<String, String> dbCreateQuery = {
  "settings":
      "CREATE TABLE settings (id INTEGER PRIMARY KEY, settingID INTEGER, settingValue TEXT)",
  "schedule_settings":
      "CREATE TABLE schedule_settings (id INTEGER PRIMARY KEY, settingID INTEGER, settingValue TEXT)",
  "class_schedule":
      "CREATE TABLE class_schedule (id INTEGER PRIMARY KEY, subjectID TEXT, subjectName TEXT, professor TEXT, classroom TEXT, color TEXT, week INTEGER, day INTEGER, startTime TEXT, endTime TEXT)",
  "homeworks":
      "CREATE TABLE homeworks (id INTEGER PRIMARY KEY, subjectID TEXT, name TEXT, description TEXT, duedate TEXT, completed TEXT)"
};
