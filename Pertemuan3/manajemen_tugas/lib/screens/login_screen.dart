import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedUsername = prefs.getString('username') ?? 'test';
    String savedPassword = prefs.getString('password') ?? 'test';

    if (_usernameController.text == savedUsername && _passwordController.text == savedPassword) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        errorMessage = 'Username atau password salah!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],  // Background warna lembut
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt,
                  size: 100,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 20),
                Text(
                  'Task Manager App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 40),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _login,
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        if (errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
