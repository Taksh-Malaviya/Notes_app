import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final GetStorage storage = GetStorage(); // Create an instance of GetStorage
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.network(
                'https://tse2.mm.bing.net/th?id=OIP.1okl9Aaxbe-3zUm5oWF51gHaHa&pid=Api&P=0&h=180',
                height: 100,
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 70,
              ),
              // Email field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email', // Label color blue
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2), // Focused border color blue
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1), // Default border color blue
                  ),
                  prefixIcon: Icon(
                    Icons.email, // Prefix icon color blue
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Password field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password', // Label color blue
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2), // Focused border color blue
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2), // Default border color blue
                  ),
                  prefixIcon: Icon(
                    Icons.lock, // Prefix icon color blue
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Login button
              ElevatedButton(
                onPressed: () {
                  String storedEmail = storage.read('email') ?? '';
                  String storedPassword = storage.read('password') ?? '';

                  if (emailController.text == storedEmail &&
                      passwordController.text == storedPassword) {
                    Get.snackbar('Login', 'Login Successful');
                    Get.offNamed('/home'); // Navigate to Home page
                  } else {
                    Get.snackbar('Error', 'Invalid email or password');
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              // Register button
              TextButton(
                onPressed: () => Get.toNamed(Routes.signup),
                child: Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
