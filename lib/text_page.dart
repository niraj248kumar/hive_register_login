import 'package:flutter/material.dart';

void main() {
  runApp(TextPage());
}

class TextPage extends StatelessWidget {
  const TextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PasswordFieldExample(),
    );
  }
}

class PasswordFieldExample extends StatefulWidget {
  const PasswordFieldExample({super.key});

  @override
  _PasswordFieldExampleState createState() => _PasswordFieldExampleState();
}

class _PasswordFieldExampleState extends State<PasswordFieldExample> {
  bool _isObscured = true; // Password initially hidden

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Hide/Show Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          obscureText: _isObscured, // Hide text when true
          decoration: InputDecoration(
            labelText: "Enter your password",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured; // Toggle password visibility
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
