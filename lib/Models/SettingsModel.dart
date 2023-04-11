class Settings {
  final String langID;
  final int classLenght;
  final int numOfWeeks;
  final String theme;

  const Settings(this.langID, this.classLenght, this.numOfWeeks, this.theme);

  static const defaultValues = Settings("en", 45, 1, 'light');
}
