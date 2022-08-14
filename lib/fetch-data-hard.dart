import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginui/details-page.dart';
import 'package:loginui/models/employee-response.dart';
import 'package:http/http.dart' as http;
import 'package:loginui/models/employee.dart';

class EmployeeDataFetch extends StatefulWidget {
  const EmployeeDataFetch({Key? key}) : super(key: key);

  @override
  State<EmployeeDataFetch> createState() => _EmployeeDataFetchState();
}

class _EmployeeDataFetchState extends State<EmployeeDataFetch> {
  Future<List> fetchEmployee() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

    final response1 =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200 && response1.statusCode == 200) {
      // Iterable l = json.decode(response.body);
      EmployeeResponse employeesPage1 =
          EmployeeResponse.fromJson(json.decode(response.body));

      EmployeeResponse employeesPage2 =
          EmployeeResponse.fromJson(json.decode(response1.body));

      var newEmployeeList = employeesPage1.employee! + employeesPage2.employee!;
      return newEmployeeList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: fetchEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List? employees = snapshot.data;
            return ListView.builder(
                itemCount: employees?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  int? id = employees![index].id;
                  String? fName = employees[index].firstName;
                  String? lName = employees[index].lastName;
                  String? email = employees[index].email;
                  String? avatar = employees[index].avatar;

                  if (fName == null ||
                      lName == null ||
                      avatar == null ||
                      id == null) {
                    return const Text('Null data');
                  } else {
                    return Card(
                      child: ListTile(
                        leading: Image.network(avatar),
                        title: Text('$fName $lName'),
                        subtitle: Text('$email'),
                        onTap: () {
                          _sendDataToDetailsPage(context, employees[index]);
                        },
                      ),
                    );
                  }
                });
          } else if (snapshot.hasError) {
            print(snapshot.error);
            throw Exception(snapshot.error);
          }
          return const CircularProgressIndicator();
        });
  }
}

void _sendDataToDetailsPage(BuildContext context, Employee employee) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailsPage(employee: employee)));
}
