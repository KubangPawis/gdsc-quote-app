import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/services/auth_service.dart';  // Import your AuthService for Firebase authentication

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Instantiate AuthService
  final AuthService _authService = AuthService();

  // Sign up function
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Call the signUp method from AuthService
      User? user = await _authService.signUpWithEmailPassword(email, password);

      if (user != null) {
        // Successful sign-up
        debugPrint("Success Sign Up");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up successful: ${user.email}')),
        );
        // You can navigate to another screen after successful sign-up
        Navigator.pushReplacementNamed(context, '/home');  // Modify '/home' with your screen
      } else {
        // Sign-up failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF262626)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Quode",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222)),
              ),
              SizedBox(height: 8.0),
              Text(
                "Create your account",
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF888888)),
              ),
              SizedBox(height: 40.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Color(0xFF888888)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF888888), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF283FB1), width: 1.0),
                        ),
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
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Color(0xFF888888)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF888888), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF283FB1), width: 2.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFF888888),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      cursorColor: Color(0xFF283FB1),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
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
                          onPressed: _signUp,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xFF888888),
                            thickness: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Or Sign Up With",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF888888)),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Color(0xFF888888), thickness: 1.0),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Flexible(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  color: Color(0xFF888888), width: 1.0),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0)),
                          onPressed: () {
                            print("Google Sign-Up Clicked");
                          },
                          icon: Image.asset(
                            'lib/assets/iconGoogle.png',
                            height: 16.0,
                            width: 16.0,
                          ),
                          label: Text(
                            "Google",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
