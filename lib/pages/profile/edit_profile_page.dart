import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = "John Doe";
  String email = "johndoe@example.com";
  String phone = "1234567890";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (val) => name = val,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (val) => email = val,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: "Phone"),
                onChanged: (val) => phone = val,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
