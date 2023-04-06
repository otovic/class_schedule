import 'package:classschedule_app/Models/SettingsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/SettingsBloc/settings_bloc.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ChooseLanguage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PETAR"),
      ),
      body: Center(
        child: Column(
          children: [
            Builder(
              builder: (context) {
                final curr =
                    context.select((SettingsBloc bloc) => bloc.state.status);
                return Text(curr.toString());
              },
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<SettingsBloc>()
                      .add(SettingsChanged(Settings.defaultValues));
                },
                child: Text('Promeni'))
          ],
        ),
      ),
    );
  }
}
