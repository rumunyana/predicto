import 'package:flutter/material.dart';
import 'homescreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background.png'), // Replace with your actual background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            // Your app logo/icon
            Image.asset(
              'assets/app_icon.png', // Replace with your actual logo/icon asset
              width: 100.0,
              height: 100.0,
            ),
            // App title
            const Text(
              'Predicto',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Welcome button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white, // Text color
                  minimumSize: const Size(double.infinity, 50), // Button size
                ),
                onPressed: () {
                  // Navigate to HomeScreen when the button is pressed
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
                child: const Text(
                  'WELCOME',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
