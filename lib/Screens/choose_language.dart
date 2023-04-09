import 'package:classschedule_app/Widgets/country_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';
import '../constants/words.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ChooseLanguage());
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: state.status == loadStatus.firstLoad ||
                  state.status == loadStatus.firstLoad2
              ? null
              : AppBar(
                  title: Text(chooseLang[state.settings.langID].toString()),
                  backgroundColor: Colors.white,
                ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.status == loadStatus.firstLoad ||
                                state.status == loadStatus.firstLoad2
                            ? "Choose language"
                            : chooseLang[state.settings.langID].toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.shortestSide * 0.6,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              CountryFlag("assets/country_flags/en.png",
                                  "English", "en"),
                              CountryFlag("assets/country_flags/sr.png",
                                  "Српски", "sr"),
                              CountryFlag("assets/country_flags/gr.png",
                                  "Deutsch", "de"),
                              CountryFlag("assets/country_flags/fr.png",
                                  "Français", "fr"),
                              CountryFlag("assets/country_flags/sp.png",
                                  "Español", "es"),
                              CountryFlag(
                                  "assets/country_flags/ar.png", "عربي", "ar"),
                              CountryFlag(
                                  "assets/country_flags/in.png", "अरबी", "in"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
