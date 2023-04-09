import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';

class ChooseInitSettings extends StatelessWidget {
  const ChooseInitSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: state.status == loadStatus.firstLoad2
              ? null
              : AppBar(
                  title: Text("NESTO"),
                ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('dataasdsdasdasdasda'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
