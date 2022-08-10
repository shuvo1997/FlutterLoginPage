import 'package:flutter/material.dart';

class MyFuruteBuildertest extends StatefulWidget {
  const MyFuruteBuildertest({Key? key}) : super(key: key);

  @override
  State<MyFuruteBuildertest> createState() => _MyFuruteBuildertestState();
}

class _MyFuruteBuildertestState extends State<MyFuruteBuildertest> {
  // final Future<String> _calculation =
  //     Future<String>.delayed(const Duration(seconds: 5), () => 'Data Loaded');

  Future<String> createOrderMessage() async {
    var user = await _fetchTestUser();
    return 'Your fetched user is $user';
  }

  Future<String> _fetchTestUser() => Future.delayed(
        const Duration(seconds: 5),
        () => 'User: 3241',
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.headline2!,
        textAlign: TextAlign.center,
        child: FutureBuilder<String>(
            future: createOrderMessage(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${snapshot.data}'),
                  )
                ];
              } else if (snapshot.hasError) {
                children = [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }));
  }
}
