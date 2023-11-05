import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TipCalculator(title: 'Tip Calculator'),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  TipCalculatorState createState() => TipCalculatorState();
}

class TipCalculatorState extends State<TipCalculator> {
  double _billAmount = 0.0;
  // Default to 15%
  double _tipPercentage = 0.15;
  bool _greatService = false;

  void _calculateTip() {
    setState(() {
      // 20% for great service, 15% otherwise
      _tipPercentage = _greatService ? 0.20 : 0.15;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _billAmount = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: const InputDecoration(
                labelText: "Bill Amount",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("Great Service?"),
                Checkbox(
                  value: _greatService,
                  onChanged: (value) {
                    setState(() {
                      _greatService = value!;
                      _calculateTip();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _calculateTip,
              child: const Text("Calculate Tip"),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Tip: \$${(_billAmount * _tipPercentage).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
