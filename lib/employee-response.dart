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

class Employee {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Employee({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }
}

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

class CreateEmployeeResponse {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  const CreateEmployeeResponse(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});
  factory CreateEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return CreateEmployeeResponse(
        name: json['name'],
        job: json['job'],
        id: json['id'],
        createdAt: json['createdAt']);
  }
}
