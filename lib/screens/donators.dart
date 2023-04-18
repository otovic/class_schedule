import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/themes.dart';
import '../constants/words.dart';

class Donators extends StatelessWidget {
  const Donators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SettingsBloc>(context),
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              donators[state.settings.langID]!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: state.settings.theme == 'light'
                ? iconThemeDark
                : iconThemeLight,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quiet[state.settings.langID]!,
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
