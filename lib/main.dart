import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AutoCompleteTextField(),
    );
  }
}

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({Key? key}) : super(key: key);

  @override
  State<AutoCompleteTextField> createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  bool isChanged = false;
  List<Continent> continentOptions = <Continent>[
    Continent(name: 'africa', size: 30370000),
    Continent(name: 'antarctica', size: 14000000),
    Continent(name: 'asia', size: 44579000),
    Continent(name: 'asia', size: 44579000),
    Continent(name: 'asia', size: 44579000),
    Continent(name: 'australia', size: 8600000),
    Continent(name: 'aurope', size: 10180000),
    Continent(name: 'aorth America', size: 24709000),
    Continent(name: 'aouth America', size: 17840000),
  ];
  List continent = [];
  TextEditingController serchController = TextEditingController();
  List<Continent> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = continentOptions;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Continent> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = continentOptions;
    } else {
      results = continentOptions
          .where((element) =>
              element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //  AutoCompleteExample(),
                (continent.isNotEmpty)
                    ? Column(
                        children: List.generate(continent.length, (index) {
                        return ListTile(
                          title: Text(continent[index]),
                          onTap: () {
                            setState(() {
                              serchController.text = continent[index];
                              continent.clear();
                            });
                          },
                        );
                      }))
                    : SizedBox(),

                TextField(
                  controller: serchController,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        isChanged = true;
                      });
                      continent.clear();
                      continentOptions.forEach((element) {
                        if (element.name[0] == val.toLowerCase()) {
                          continent.add(element.name.toString());
                          print(continent);
                        }
                        if (element.name.substring(0, 2) == val.toLowerCase()) {
                          // continent.clear();
                          continent.add(element.name.toString());
                          print(continent);
                        }
                        if (element.name.substring(0, 3) == val.toLowerCase()) {
                          // continent.clear();
                          continent.add(element.name.toString());
                          print(continent);
                        }
                      });
                      print(isChanged);
                    } else {
                      setState(() {
                        continent.clear();
                        isChanged = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Continent {
  const Continent({
    required this.name,
    required this.size,
  });

  final String name;
  final int size;

  @override
  String toString() {
    return '$name ($size)';
  }
}
