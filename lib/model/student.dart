import 'dart:ffi';

enum Gender { male, female }

enum Medium { english, gujarati }

enum Standard { kg1, kg2 }

class Student {
  Student({
    required this.key,
    required this.rollNumber,
    required this.name,
    required this.gender,
    required this.medium,
    required this.standard,
  });
  String key;
  int rollNumber;
  String name;
  Gender gender;
  Medium medium;
  Standard standard;
}

Map<String, DateAndAttendance> studentAttendance = {};

class DateAndAttendance {
  DateAndAttendance({required this.todaysDate, required this.isPresent});
  DateTime todaysDate;
  Bool isPresent;
}
