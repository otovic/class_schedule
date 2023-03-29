class Subject {
  final String subjectName;
  final String? classroom;

  const Subject( this.subjectName, this.classroom );

  static const empty = Subject('', '');
}