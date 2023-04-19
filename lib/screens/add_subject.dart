import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Widgets/input_dialog.dart';
import 'package:classschedule_app/constants/words.dart';
import 'package:classschedule_app/screens/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/themes.dart';

class AddSubject extends StatefulWidget {
  AddSubject({Key? key}) : super(key: key);

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController professorController = TextEditingController();
  TextEditingController classroomController = TextEditingController();
  Color selectedColor = const Color.fromRGBO(0, 123, 255, 1);

  void setCollor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              addSubject[state.settings.langID]!,
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: settingsBloc.state.settings.theme == 'light'
                ? iconThemeDark
                : iconThemeLight,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputDialog(
                    placeholderText: "${subjectID[state.settings.langID]!}",
                    controller: idController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDialog(
                    placeholderText: "${subjectName[state.settings.langID]!}",
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDialog(
                    placeholderText:
                        "${subjectProfessor[state.settings.langID]!}",
                    controller: professorController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputDialog(
                    placeholderText:
                        "${subjectClassroom[state.settings.langID]!}",
                    controller: professorController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            subjectColor[state.settings.langID]!,
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ColorPickerScreen(
                                  selectColor: (color) {
                                    setCollor(color);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.white38, width: 3),
                              color: selectedColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
