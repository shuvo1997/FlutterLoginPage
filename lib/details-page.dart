import 'package:flutter/material.dart';
import 'package:loginui/employee-response.dart';

class DetailsPage extends StatefulWidget {
  final Employee employee;
  const DetailsPage({Key? key, required this.employee}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
        child: Column(
          children: [
            Image.network(widget.employee.avatar!),
            Text(
              '${widget.employee.firstName!} ${widget.employee.lastName!}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
