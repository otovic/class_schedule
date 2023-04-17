import 'package:classschedule_app/Blocs/SettingsBloc/settings_bloc.dart';
import 'package:classschedule_app/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  Future<void> _changeToMainScreen(BuildContext context) async {
    Future.delayed(Duration(seconds: 2));
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        if (state.status != loadStatus.loading) {
          _changeToMainScreen(context);
        }

        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
