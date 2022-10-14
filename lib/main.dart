import 'package:auto_complate_text_field/searchBarWidget.dart';
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
      debugShowCheckedModeBanner: false,
      home: AutoCompleteTextField(),
      // home: SearchBarScreen(),
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
    Continent(name: 'Africa', size: 30370000),
    Continent(name: 'Antarctica', size: 14000000),
    Continent(name: 'Asia', size: 44579000),
    Continent(name: 'Asia', size: 44579000),
    Continent(name: 'Asia', size: 44579000),
    Continent(name: 'Australia', size: 8600000),
    Continent(name: 'Europe', size: 10180000),
    Continent(name: 'North America', size: 24709000),
    Continent(name: 'South America', size: 17840000),
  ];
  List continent = [];
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
                (_foundUsers.isNotEmpty)
                    ? Column(
                        children: List.generate(_foundUsers.length, (index) {
                        return ListTile(
                          title: Text(_foundUsers[index].name),
                        );
                      }))
                    : SizedBox(),

                TextField(
                  // controller: userController,
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15),
                    hintText: "Search",
                    suffixIcon: const Icon(Icons.search),
                    // prefix: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchBarScreen(),
                        ));
                  },
                  child: Text("Search Bar Widgets"),
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
