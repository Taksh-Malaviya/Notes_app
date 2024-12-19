import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Notes_Controller/Notes_Controller.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final AuthController signupController = Get.put(AuthController());
  final GetStorage storage = GetStorage();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Image Picker
            GestureDetector(
              onTap: () => _showImagePickerOptions(context),
              child: Obx(
                () => CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: signupController.selectedImage.value != null
                      ? FileImage(signupController.selectedImage.value!)
                      : null,
                  child: signupController.selectedImage.value == null
                      ? Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                          size: 40,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tap to select an image',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Full Name Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.blue),
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Email Field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blue),
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Password Field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blue),
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                // Save user data
                storage.write('email', emailController.text);
                storage.write('password', passwordController.text);

                Get.snackbar('Sign-Up', 'Account Created Successfully');
                Get.offNamed('/login'); // Navigate to Login page
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  // Show Image Picker Options
  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                signupController.pickImageFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                signupController.captureImageWithCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
