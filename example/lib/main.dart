import 'package:apple_color_list/apple_color_list.dart';
import 'package:apple_color_list_example/color_list_reader.dart';
import 'package:apple_color_list_example/color_list_writer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppView());
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Apple Color List Demo',
      home: AppContentView(),
    );
  }
}

class AppContentView extends StatelessWidget {
  const AppContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Apple Color List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Read Color Lists'),
              Tab(text: 'Write Color Lists'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ColorListReadView(),
            ColorListWriteView(),
          ],
        ),
      ),
    );
  }
}

class ColorListReadView extends StatefulWidget {
  const ColorListReadView({super.key});

  @override
  State<ColorListReadView> createState() => _ColorListReadViewState();
}

class _ColorListReadViewState extends State<ColorListReadView> {
  List<AppleColorList> _loadedColorLists = [];

  @override
  void initState() {
    super.initState();
    _loadColorLists();
  }

  Future<void> _loadColorLists() async {
    final colorListLoader = ColorListReader(AppleColorListPlugin());
    final colorLists = await colorListLoader.loadColorLists();
    setState(() {
      _loadedColorLists = colorLists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _loadedColorLists.length,
      itemBuilder: (context, index) {
        final colorList = _loadedColorLists[index];
        return ExpansionTile(
          title: Text(colorList.name),
          children: colorList.colors.map((color) {
            return ListTile(
              leading: Container(
                width: 24,
                height: 24,
                color: Color.fromRGBO(
                  (color.red * 255).round(),
                  (color.green * 255).round(),
                  (color.blue * 255).round(),
                  color.alpha,
                ),
              ),
              title: Text(color.name),
              subtitle: Text(
                'R: ${color.red.toStringAsFixed(2)}, '
                'G: ${color.green.toStringAsFixed(2)}, '
                'B: ${color.blue.toStringAsFixed(2)}, '
                'A: ${color.alpha.toStringAsFixed(2)}',
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ColorListWriteView extends StatefulWidget {
  const ColorListWriteView({super.key});

  @override
  State<ColorListWriteView> createState() => _ColorListWriteViewState();
}

class _ColorListWriteViewState extends State<ColorListWriteView> {
  final List<AppleColor> _colors = [
    AppleColor(
      name: 'Systemred',
      red: 1.0,
      green: 0.0,
      blue: 0.0,
      alpha: 1.0,
    ),
    AppleColor(
      name: 'Systemgreen',
      red: 0.0,
      green: 1.0,
      blue: 0.0,
      alpha: 1.0,
    ),
    AppleColor(
      name: 'Systemblue',
      red: 0.0,
      green: 0.0,
      blue: 1.0,
      alpha: 1.0,
    ),
    AppleColor(
      name: 'Systemyellow',
      red: 1.0,
      green: 1.0,
      blue: 0.0,
      alpha: 1.0,
    ),
    AppleColor(
      name: 'Systempurple',
      red: 0.5,
      green: 0.0,
      blue: 0.5,
      alpha: 1.0,
    ),
  ];

  void _saveColorList() {
    final colorList = AppleColorList(
      name: 'SystemColors',
      colors: _colors,
    );

    final colorListWriter = ColorListWriter(AppleColorListPlugin());
    colorListWriter.writeColorList(colorList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _colors.length,
        itemBuilder: (context, index) {
          final color = _colors[index];
          return ListTile(
            leading: Container(
              width: 24,
              height: 24,
              color: Color.fromRGBO(
                (color.red * 255).round(),
                (color.green * 255).round(),
                (color.blue * 255).round(),
                color.alpha.toDouble(),
              ),
            ),
            title: Text(color.name),
            subtitle: Text(
              'R: ${color.red.toStringAsFixed(2)}, '
              'G: ${color.green.toStringAsFixed(2)}, '
              'B: ${color.blue.toStringAsFixed(2)}, '
              'A: ${color.alpha.toStringAsFixed(2)}',
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveColorList,
        tooltip: 'Save Color List',
        child: const Icon(Icons.save),
      ),
    );
  }
}
