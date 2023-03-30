part of './SettingsBloc.dart';

abstract class SettingsEvents {
  const SettingsEvents();
}

class SettingsChanged extends SettingsEvents {
  final Settings settings;
  const SettingsChanged(this.settings);
}

class InitSettings extends SettingsEvents {
  const InitSettings();
}
