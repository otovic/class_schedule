import 'package:classschedule_app/Screens/choose_language.dart';
import 'package:classschedule_app/Widgets/option_selector.dart';
import 'package:classschedule_app/constants/themes.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';
import '../Services/utility.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const ChooseLanguage()));
                      },
                      title: language[settingsBloc.state.settings.langID]!,
                      value: UtilityService.getLanguage(state.settings.langID)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
