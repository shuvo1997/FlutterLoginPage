import 'package:flutter/material.dart';
import 'package:loginui/person-model.dart';

class MyFutureBuilderTest extends StatefulWidget {
  const MyFutureBuilderTest({Key? key}) : super(key: key);

  @override
  State<MyFutureBuilderTest> createState() => _MyFutureBuilderTestState();
}

class _MyFutureBuilderTestState extends State<MyFutureBuilderTest> {
  List<Person> personsList = List<Person>.generate(
      1000,
      (_) => Person(
          name: 'Shovon Karmaker', age: 25, email: 'shuvokkr@gmail.com'));

  Future<List<Person>> createOrderMessage() async {
    var user = await _fetchTestUser();
    return user;
  }

  Future<List<Person>> _fetchTestUser() => Future.delayed(
        const Duration(seconds: 2),
        () => personsList,
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
        future: createOrderMessage(),
        builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text(
                    'Awating for lists',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
                child: ListView.builder(
                    itemCount: personsList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          title: Text(
                            personsList[index].name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(
                              '${personsList[index].email}\n${personsList[index].age}'),
                          trailing: const Icon(Icons.menu),
                          onTap: () {
                            print('$index pressed');
                          },
                        ),
                      );
                    }));
          }
          return Center(
            child: Column(
              children: const [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Text('Awaiting for lists')
              ],
            ),
          );
        });
  }
}
