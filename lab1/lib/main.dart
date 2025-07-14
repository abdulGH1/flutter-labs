import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0.0; // ✅ Changed from int to var with 0.0
  double myFontSize = 30.0; // ✅ Added myFontSize variable

  void _incrementCounter() {
    setState(() {
      _counter += 1.0;
    });
  }

  void setNewValue(double value) {
    setState(() {
      myFontSize = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text( // ✅ Removed `const` and added style
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: myFontSize),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: myFontSize),
            ),
            Slider( // ✅ Added Slider widget
              min: 10,
              max: 100,
              value: myFontSize,
              onChanged: setNewValue,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
