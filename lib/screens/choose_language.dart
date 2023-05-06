import 'package:classschedule_app/widgets/country_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/settings_bloc/settings_bloc.dart';
import '../constants/themes.dart';
import '../constants/words.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

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
                  title: Text(
                    language[state.settings.langID].toString(),
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  iconTheme: settingsBloc.state.settings.theme == 'light'
                      ? iconThemeDark
                      : iconThemeLight,
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
                            ? "Choose Language"
                            : chooseLang[state.settings.langID].toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).backgroundColor),
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
                              CountryFlag("assets/country_flags/it.png",
                                  "Italiano", "it"),
                              CountryFlag("assets/country_flags/ru.png",
                                  "Русский", "ru"),
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
