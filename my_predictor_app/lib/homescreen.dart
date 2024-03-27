import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _feature1Controller = TextEditingController();
  final _feature2Controller = TextEditingController();
  String _predictionResult = '';

  void _submitData() {
    // This function will be replaced with the logic to handle the data submission and fetch the prediction.
    // Assuming the prediction is fetched from a model or backend.
    setState(() {
      _predictionResult =
          'Prediction: ${_feature1Controller.text} and ${_feature2Controller.text}';
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _feature1Controller.dispose();
    _feature2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictor App'),
        elevation: 0, // Removes the shadow under the app bar.
      ),
      body: SingleChildScrollView(
        // Ensures the view is scrollable when the keyboard is open
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _feature1Controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: 'Enter Feature 1',
                  labelText: 'Feature 1',
                  border:
                      OutlineInputBorder(), // Adds a border around the text field
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _feature2Controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: 'Enter Feature 2',
                  labelText: 'Feature 2',
                  border:
                      OutlineInputBorder(), // Adds a border around the text field
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15), // Button padding
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 20),
              // Display the prediction result inside a container to enhance the UI
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50], // A light color for the container
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Text(
                  _predictionResult.isEmpty
                      ? 'Your prediction will be displayed here'
                      : _predictionResult,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
