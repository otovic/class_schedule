part of './settings_bloc.dart';

abstract class SettingsEvents {
  const SettingsEvents();
}

class SettingsChanged extends SettingsEvents {
  final Settings settings;
  const SettingsChanged(this.settings);
}

class revertSetting extends SettingsEvents {
  const revertSetting();
}

class InitSettings extends SettingsEvents {
  const InitSettings();
}
