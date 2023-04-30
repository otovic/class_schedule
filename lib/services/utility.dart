import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilityService {
  static getLanguage(String index) {
    switch (index) {
      case "en":
        return "English";
      case "sr":
        return "Српски";
    }
  }

  static void launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String formatTime(int num) {
    return num < 10 ? "0${num}" : num.toString();
  }

  static String encodeColor(Color color) {
    return "${color.red}:${color.green}:${color.blue}:${color.opacity}";
  }

  static String encodeTime(TimeOfDay timeOfDay) {
    return "${timeOfDay.hour}:${timeOfDay.minute}";
  }

  static TimeOfDay decodeTime(String time) {
    List<String> values = time.split(":");
    return TimeOfDay(
      hour: int.parse(values[0]),
      minute: int.parse(values[1]),
    );
  }

  static Color decodeColor(String color) {
    List<String> values = color.split(":");
    return Color.fromRGBO(
      int.parse(values[0]),
      int.parse(values[1]),
      int.parse(values[2]),
      double.parse(values[3]),
    );
  }

  static String generateTimeText(TimeOfDay startTime, TimeOfDay endTime) {
    return "${formatTime(startTime.hour)}:${formatTime(startTime.minute)} - ${formatTime(endTime.hour)}:${formatTime(endTime.minute)}";
  }

  static String encodeBool(bool value) {
    return value == true ? "1" : "0";
  }

  static bool decodeBool(String value) {
    return value == "1" ? true : false;
  }

  static double addTimeOfDay(TimeOfDay t1, TimeOfDay t2) {
    double parsedT1 = (t1.hour + t1.minute) / 60;
    double parsedT2 = (t2.hour + t2.minute) / 60;

    return parsedT2 - parsedT1;
  }
}
