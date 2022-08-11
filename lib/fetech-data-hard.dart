import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginui/employee-response.dart';
import 'package:http/http.dart' as http;

class EmployeeDataFetch extends StatefulWidget {
  const EmployeeDataFetch({Key? key}) : super(key: key);

  @override
  State<EmployeeDataFetch> createState() => _EmployeeDataFetchState();
}

class _EmployeeDataFetchState extends State<EmployeeDataFetch> {
  Future<List<Employee>?> fetchEmployee() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      // Iterable l = json.decode(response.body);
      EmployeeResponse employees =
          EmployeeResponse.fromJson(json.decode(response.body));
      return employees.employee;
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
    return FutureBuilder<List<Employee>?>(
        future: fetchEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Employee>? employees = snapshot.data;
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
                        title: Text('ID: $id $fName $lName'),
                        subtitle: Text('$email'),
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
