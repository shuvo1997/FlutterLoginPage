import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginui/models/employee-response.dart';
import 'package:loginui/models/employee.dart';
import 'package:http/http.dart' as http;
import 'package:loginui/models/single-employee.dart';

class DetailsPage extends StatefulWidget {
  final Employee employee;
  const DetailsPage({Key? key, required this.employee}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<Employee> _fetchEmployee() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users/${widget.employee.id}'));
    if (response.statusCode == 200) {
      Employee employee =
          SingleEmployee.fromJson(json.decode(response.body)).data;
      return employee;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  DetailsPage get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
      ),
      body: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: FutureBuilder<Employee>(
              future: _fetchEmployee(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Image.network(snapshot.data!.avatar!),
                      Text(
                          '${snapshot.data!.firstName} ${snapshot.data!.lastName}')
                    ],
                  );
                }
                if (snapshot.hasError) {
                  throw Exception('Exception in future builder');
                }
                return const CircularProgressIndicator();
              })),
    );
  }
}
