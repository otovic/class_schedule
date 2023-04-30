import 'package:classschedule_app/blocs/settings_bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/color_box.dart';
import '../constants/themes.dart';
import '../constants/words.dart';

class ColorPickerScreen extends StatelessWidget {
  final Function selectColor;
  const ColorPickerScreen({required this.selectColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(subjectColor[state.settings.langID]!),
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: settingsBloc.state.settings.theme == 'light'
                ? iconThemeDark
                : iconThemeLight,
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: MediaQuery.of(context).size.shortestSide * 0.08,
              mainAxisSpacing: MediaQuery.of(context).size.shortestSide * 0.08,
              children: [
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(0, 123, 255, 1));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(0, 123, 255, 1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(56, 152, 255, 1));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(56, 152, 255, 1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(107, 176, 255, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(107, 176, 255, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 136, 0, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 136, 0, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 157, 46, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 157, 46, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 177, 79, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 177, 79, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 0, 0, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 0, 0, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 57, 57, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 82, 82, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 84, 84, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 115, 115, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(0, 255, 42, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(0, 255, 42, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(166, 255, 70, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(166, 255, 70, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(156, 255, 141, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(156, 255, 141, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(123, 0, 255, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(123, 0, 255, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(150, 52, 255, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(150, 52, 255, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(173, 101, 255, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(173, 101, 255, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 213, 0, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 213, 0, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 245, 79, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 245, 79, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 240, 122, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 240, 122, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 98, 0, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 98, 0, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 137, 60, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 137, 60, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 153, 88, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 153, 88, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 0, 242, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 0, 242, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 57, 245, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 57, 245, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(255, 117, 248, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(255, 117, 248, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(95, 95, 95, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(95, 95, 95, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(141, 141, 141, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(141, 141, 141, 1.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectColor(Color.fromRGBO(208, 208, 208, 1.0));
                    Navigator.of(context).pop();
                  },
                  child: ColorBox(
                    color: Color.fromRGBO(208, 208, 208, 1.0),
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
