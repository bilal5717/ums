class Course {
  final int id;
  final String courseCode;
  final String subjects;
  final String section;
  final String teachers;
  final double attendancePercentage; // Added attendance percentage

  Course(this.id, this.courseCode, this.subjects, this.section, this.teachers, this.attendancePercentage);
}