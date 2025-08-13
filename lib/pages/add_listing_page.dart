import 'package:flutter/material.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({super.key});

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final _formKey = GlobalKey<FormState>();

  String title = "";
  String price = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Listing")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  onChanged: (val) => title = val,
                  validator: (val) => val!.isEmpty ? "Enter a title" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => price = val,
                  validator: (val) => val!.isEmpty ? "Enter a price" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  maxLines: 3,
                  onChanged: (val) => description = val,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Listing Added")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add Listing"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
