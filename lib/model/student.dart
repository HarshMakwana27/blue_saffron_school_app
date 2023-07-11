import 'dart:ffi';

enum Gender { male, female }

enum Medium { english, gujarati }

enum Standard { KG1, KG2 }

class Student {
  Student({
    required this.key,
    required this.rollNumber,
    required this.name,
    required this.gender,
    required this.medium,
    required this.standard,
    required this.joiningDate,
  });
  String key;
  int rollNumber;
  String name;
  Gender gender;
  Medium medium;
  Standard standard;
  DateTime joiningDate;
}

Map<String, DateAndAttendance> studentAttendance = {};

class DateAndAttendance {
  DateAndAttendance({required this.todaysDate, required this.isPresent});
  DateTime todaysDate;
  Bool isPresent;
}
