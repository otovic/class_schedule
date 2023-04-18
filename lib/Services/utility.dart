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
}
