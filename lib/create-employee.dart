import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginui/employee-response.dart';

class CreateEmployeeForm extends StatefulWidget {
  const CreateEmployeeForm({Key? key}) : super(key: key);

  @override
  State<CreateEmployeeForm> createState() => _CreateEmployeeFormState();
}

class _CreateEmployeeFormState extends State<CreateEmployeeForm> {
  String employeeName = "";
  String job = "";

  final _createEmployeeFormKey = GlobalKey<FormState>();

  Future<CreateEmployeeResponse>? _futureResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Employee Form'),
        ),
        body: Container(
            child: (_futureResponse == null)
                ? buildForm(_createEmployeeFormKey, employeeName, job)
                : buildFutureBuilder()));
  }

  FutureBuilder<CreateEmployeeResponse> buildFutureBuilder() {
    return FutureBuilder<CreateEmployeeResponse>(
        future: _futureResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildForm(_createEmployeeFormKey, employeeName, job);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }

  Form buildForm(GlobalKey<FormState> createEmployeeFormKey,
      String employeeName, String job) {
    return Form(
      key: createEmployeeFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onSaved: (value) {
                  employeeName = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onSaved: (value) {
                  job = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Enter Job'),
              ),
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (createEmployeeFormKey.currentState!.validate()) {
                    createEmployeeFormKey.currentState!.save();
                    setState(() {
                      _futureResponse =
                          _sendEmployeeData(name: employeeName, job: job);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(mySnackBar('Data sent successfully'));
                    });
                  } else {
                    print('Validation error');
                  }
                },
                child: const Text('Send Post Data'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<CreateEmployeeResponse> _sendEmployeeData(
      {required String name, required String job}) async {
    final response = await http.post(Uri.parse('https://reqres.in/api/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': name, 'job': job}));
    if (response.statusCode == 201) {
      return CreateEmployeeResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Exception in _sendEmployeeData');
    }
  }

  mySnackBar(String msg) {
    return SnackBar(content: Text(msg));
  }
}
