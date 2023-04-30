import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/settings_bloc/settings_bloc.dart';

class CountryFlag extends StatelessWidget {
  final String countryFlag;
  final String language;
  final String langIndex;
  const CountryFlag(this.countryFlag, this.language, this.langIndex,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return ButtonTheme(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              try {
                if (state.status == loadStatus.firstLoad) {
                  settingsBloc.add(insertDefaultLanguage(langIndex));
                  print("OVDE");
                  Navigator.of(context).pop();
                } else {
                  settingsBloc.add(ChangeLanguage(langIndex));
                  print("OVDE@2222");
                  Navigator.of(context).pop();
                }
              } catch (e) {
                print("GRESKAAA");
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: Colors.lightBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  child: Image(
                    image: AssetImage(countryFlag),
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.2,
                  child: Center(
                    child: Text(
                      language,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
