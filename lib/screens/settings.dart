import 'package:classschedule_app/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:classschedule_app/screens/choose_language.dart';
import 'package:classschedule_app/widgets/option_selector.dart';
import 'package:classschedule_app/constants/themes.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:classschedule_app/screens/donators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/settings_bloc/settings_bloc.dart';
import '../services/utility.dart';
import 'donations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final scheduleBloc = BlocProvider.of<ScheduleBloc>(context);

    return BlocBuilder(
        bloc: scheduleBloc,
        builder: (BuildContext context, ScheduleState schState) {
          return BlocBuilder(
            bloc: settingsBloc,
            builder: (BuildContext context, SettingsState state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    settings[state.settings.langID]!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  iconTheme: settingsBloc.state.settings.theme == 'light'
                      ? iconThemeDark
                      : iconThemeLight,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                bottomNavigationBar: BottomAppBar(
                  color: Theme.of(context).primaryColor,
                  height: MediaQuery.of(context).size.shortestSide * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: MediaQuery.of(context).size.shortestSide * 0.1,
                      )
                    ],
                  ),
                ),
                body: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        OptionSelector(
                          icon: Icons.format_paint_outlined,
                          function: () {
                            settingsBloc.add(ChangeTheme());
                          },
                          title: theme[settingsBloc.state.settings.langID]!,
                          value: settingsBloc.state.settings.theme == 'light'
                              ? light[settingsBloc.state.settings.langID]!
                              : dark[settingsBloc.state.settings.langID]!,
                        ),
                        OptionSelector(
                          icon: Icons.language_outlined,
                          function: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ChooseLanguage(),
                              ),
                            );
                          },
                          title: language[settingsBloc.state.settings.langID]!,
                          value:
                              UtilityService.getLanguage(state.settings.langID),
                        ),
                        OptionSelector(
                          icon: Icons.view_week_outlined,
                          function: () {
                            int val = 0;
                            if (schState.numberOfWeeks + 1 > 4) {
                              val = 1;
                            } else {
                              val = schState.numberOfWeeks + 1;
                            }

                            scheduleBloc.add(
                              ChangeWeekNumber(val),
                            );
                          },
                          title:
                              numOfWeeks[settingsBloc.state.settings.langID]!,
                          value: schState.numberOfWeeks.toString(),
                        ),
                        OptionSelector(
                          icon: Icons.catching_pokemon_outlined,
                          function: () {
                            UtilityService.launchURL(
                                'https://github.com/petarotovic/class_schedule');
                          },
                          title: "GitHub",
                          value: checkGitHub[state.settings.langID]!,
                        ),
                        OptionSelector(
                          icon: Icons.monetization_on_outlined,
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const Donations()));
                          },
                          title: donations[state.settings.langID]!,
                          value: donationsDesc[state.settings.langID]!,
                        ),
                        OptionSelector(
                          icon: Icons.person_2_outlined,
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const Donators()));
                          },
                          title: donators[state.settings.langID]!,
                          value: donatorsDesc[state.settings.langID]!,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
