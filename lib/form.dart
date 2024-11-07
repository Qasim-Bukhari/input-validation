// form.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ValidationScreen extends StatefulWidget {
  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for each TextField
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Center(child: Text('Form')),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              buildTextFormField(
                controller: nameController,
                label: 'Name',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.startsWith(' ')) {
                    return 'Name cannot start with a space';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Name should contain only alphabetic characters and spaces';
                  }
                  return null;
                },
              ),
              // Email Field
              buildTextFormField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (value.startsWith(' ')) {
                    return 'Email cannot start with a space';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              // CNIC Field
              buildTextFormField(
                controller: cnicController,
                label: 'CNIC',
                icon: Icons.badge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your CNIC';
                  }
                  if (value.startsWith(' ')) {
                    return 'CNIC cannot start with a space';
                  }
                  if (!RegExp(r'^\d{13}$').hasMatch(value)) {
                    return 'CNIC must be exactly 13 digits';
                  }
                  return null;
                },
              ),
              // Contact Number Field
              buildTextFormField(
                controller: contactNumberController,
                label: 'Contact Number',
                icon: Icons.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  if (value.startsWith(' ')) {
                    return 'Contact number cannot start with a space';
                  }
                  if (!RegExp(r'^\+?\d{10,12}$').hasMatch(value)) {
                    return 'Contact number must be between 10 to 12 digits, optionally starting with +';
                  }
                  return null;
                },
              ),
              // Address Field
              buildTextFormField(
                controller: addressController,
                label: 'Address',
                icon: Icons.home,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  if (value.startsWith(' ')) {
                    return 'Address cannot start with a space';
                  }
                  return null;
                },
              ),
              // Password Field
              buildTextFormField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.startsWith(' ')) {
                    return 'Password cannot start with a space';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[\W_]).+$').hasMatch(value)) {
                    return 'Password must contain letters, numbers, and symbols';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form is valid!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )
                ),
                child: Text('Submit', style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
