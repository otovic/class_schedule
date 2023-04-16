class Settings {
  final String langID;
  final int numOfWeeks;
  final String theme;

  const Settings(this.langID, this.numOfWeeks, this.theme);

  static const defaultValues = Settings("en", 1, 'light');
}
