import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Sign Up", 
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF262626))))
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Quode",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222)
                )
              ),
              SizedBox(height: 8.0),
              Text(
                "Create your account",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF888888)
                )
              ),
            SizedBox(height: 40.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF283FB1),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      print("Email: ${_emailController.text}");
                      print("Password: ${_passwordController.text}");
                    }
                  },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF)
                  )), 
              )))
            ],
          )
        )
      );
  }
}
