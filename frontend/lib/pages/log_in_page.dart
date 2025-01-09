import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Add Google Sign-In import
import 'sign_up_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Google SignIn instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Google login function
  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      // Initiate Google Sign-In process
      GoogleSignInAccount? user = await _googleSignIn.signIn();

      // If successful, print the user info or navigate to home screen
      if (user != null) {
        print('Logged in with Google: ${user.displayName}');
        // You can navigate to a new page here (like the home page or dashboard)
      }
    } catch (error) {
      print('Error with Google login: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Log In",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF262626),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Log in to your account",
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                color: Color(0xFF888888),
              ),
            ),
            SizedBox(height: 40.0),

            // Form for email and password
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
                        borderSide: BorderSide(color: Color(0xFF888888)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF283FB1), width: 2.0),
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
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xFF888888)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF888888)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF283FB1), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),

                  // Log in button
                  SizedBox(
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
                          // Add your login logic here (e.g., Firebase authentication)
                        }
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Divider and Google Sign-In button
                  Center(
                    child: Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Or Log in with",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Color(0xFF888888), width: 1.0),
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)
                          ),
                          icon: Image.asset(
                            'lib/assets/iconGoogle.png', 
                            height: 16.0,
                            width: 16.0,
                          ),
                          label: Text(
                            "Log in with Google",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () => _loginWithGoogle(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF888888),
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF283FB1),
                              ),
                            ),
                          ],
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
    );
  }
}
