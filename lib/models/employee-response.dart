import 'package:loginui/models/employee.dart';
import 'package:loginui/models/support.dart';
import 'package:loginui/models/single-employee.dart';

class EmployeeResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Employee>? employee;
  Support? support;

  EmployeeResponse(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.employee,
      this.support});

  EmployeeResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      employee = <Employee>[];
      json['data'].forEach((v) {
        employee!.add(Employee.fromJson(v));
      });
    }
    support =
        json['support'] != null ? Support.fromJson(json['support']) : null;
  }
}
