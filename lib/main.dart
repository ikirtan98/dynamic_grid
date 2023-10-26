import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DynamicGrid(),
    );
  }
}

class DynamicGrid extends StatefulWidget {
  const DynamicGrid({super.key});

  @override
  State<DynamicGrid> createState() => _DynamicGridState();
}

class _DynamicGridState extends State<DynamicGrid> {
  TextEditingController row = TextEditingController();
  TextEditingController column = TextEditingController();
  TextEditingController searchController = TextEditingController();

  int rowC = 0;
  int colC = 0;
  List<String> gridData = [];

  // Function to clear the grid and text fields
  void clearGridAndFields() {
    row.clear();
    column.clear();
    searchController.clear();
    rowC = 0;
    colC = 0;
    gridData.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Grid'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Row"),
              TextField(
                controller: row,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Enter Row',
                  labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                      ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Column"),
              TextField(
                controller: column,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Enter Column',
                  labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                      ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      rowC = int.parse(row.text);
                      colC = int.parse(column.text);
                      gridData = List.generate(rowC * colC, (index) {
                        return String.fromCharCode('A'.codeUnitAt(0) + index);
                      });
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("Add"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        clearGridAndFields, // Clear button to clear the grid and fields
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("Clear"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Alphabet',
                ),
                onChanged: (query) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              if (rowC > 0 && colC > 0)
                SizedBox(
                  child: GridView.builder(
                    itemCount: colC * rowC,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowC,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      final cellCharacter = gridData[index].toLowerCase();
                      final searchQuery = searchController.text.toLowerCase();

                      // Split the searchQuery into individual characters
                      final searchCharacters = searchQuery.split('');

                      // Check if the cell character matches any of the search characters
                      final isHighlighted = searchCharacters
                          .any((char) => cellCharacter.contains(char));

                      return Container(
                        color: isHighlighted ? Colors.blue : Colors.greenAccent,
                        child: Center(
                          child: Text(gridData[index]),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
