import 'package:loginui/models/employee.dart';
import 'package:loginui/models/support.dart';

class SingleEmployee {
  Employee data;
  Support support;

  SingleEmployee({required this.data, required this.support});

  factory SingleEmployee.fromJson(Map<String, dynamic> json) {
    return SingleEmployee(
        data: Employee.fromJson(json['data']),
        support: Support.fromJson(json['support']));
  }
}
