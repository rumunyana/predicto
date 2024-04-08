// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Predictor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tvBudgetController = TextEditingController();
  String _predictionResult = "Predicted sales will be shown here.";
  bool _isLoading = false;

  void _submitData() async {
    setState(() {
      _isLoading = true;
    });
    final tvBudget = double.tryParse(_tvBudgetController.text);
    if (tvBudget != null) {
      await _predictTvSales(tvBudget);
    } else {
      _showSnackBar('Please enter a valid number.');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _predictTvSales(double tvBudget) async {
    final url = Uri.parse('https://predicting-2.onrender.com/predict');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'X': [tvBudget]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _predictionResult =
              "Predicted Sales: \$${data['predictions'][0].toStringAsFixed(2)}";
        });
      } else {
        _showSnackBar(
            "Failed to predict TV sales. Status code: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar("An error occurred: $e");
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Predictor App'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/sales-predictor.jpg', height: 100),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _tvBudgetController,
                        decoration: const InputDecoration(
                          labelText: 'TV Advertising Budget',
                          hintText: 'Enter your TV advertising budget',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.tv), // Clearer context
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _submitData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Consistent with theme
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Get Prediction',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _predictionResult,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ));
  }
}
