part of 'settings_bloc.dart';

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

class insertDefaultLanguage extends SettingsEvents {
  final String lang;
  const insertDefaultLanguage(this.lang);
}

class changeToFirstLoad2 extends SettingsEvents {
  final String lang;
  const changeToFirstLoad2(this.lang);
}

class InitSettings extends SettingsEvents {
  const InitSettings();
}

class ChangeTheme extends SettingsEvents {
  const ChangeTheme();
}

class ChangeLanguage extends SettingsEvents {
  final String language;
  const ChangeLanguage(this.language);
}

class ChangeWeekNum extends SettingsEvents {
  const ChangeWeekNum();
}
