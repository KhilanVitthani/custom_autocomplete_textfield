import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      home: SafeArea(
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
                          if (element.name.substring(0, 2) ==
                              val.toLowerCase()) {
                            // continent.clear();
                            continent.add(element.name.toString());
                            print(continent);
                          }
                          if (element.name.substring(0, 3) ==
                              val.toLowerCase()) {
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

//
// class AutoCompleteExample extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _AutoCompleteExampleState();
// }
//
// class _AutoCompleteExampleState extends State<AutoCompleteExample> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(15.0),
//       child: Container(
//         alignment: Alignment.bottomCenter,
//         child: Autocomplete<Continent>(
//           fieldViewBuilder: (BuildContext context,
//               TextEditingController fieldTextEditingController,
//               FocusNode fieldFocusNode,
//               VoidCallback onFieldSubmitted) {
//             return TextField(
//               controller: fieldTextEditingController,
//               focusNode: fieldFocusNode,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             );
//           },
//           optionsBuilder: (TextEditingValue textEditingValue) {
//             return continentOptions
//                 .where((Continent continent) => continent.name
//                     .toLowerCase()
//                     .startsWith(textEditingValue.text.toLowerCase()))
//                 .toList();
//           },
//           displayStringForOption: (Continent option) => option.name,
//           onSelected: (Continent selection) {
//             print('Selected: ${selection.name}');
//           },
//           optionsViewBuilder: (BuildContext context,
//               AutocompleteOnSelected<Continent> onSelected,
//               Iterable<Continent> options) {
//             return Align(
//               alignment: Alignment.topLeft,
//               child: Material(
//                 child: Container(
//                   width: 300,
//                   color: Colors.teal,
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(10.0),
//                     itemCount: options.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final Continent option = options.elementAt(index);
//
//                       return GestureDetector(
//                         onTap: () {
//                           onSelected(option);
//                         },
//                         child: ListTile(
//                           title: Text(option.name,
//                               style: const TextStyle(color: Colors.white)),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
