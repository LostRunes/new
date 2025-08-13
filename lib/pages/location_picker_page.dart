import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({Key? key}) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _suggestions = [];

  // Fetch suggestions from Nominatim API
  Future<void> _fetchSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }

    final String url =
        "https://nominatim.openstreetmap.org/search?q=$input&format=json&addressdetails=1&limit=10";

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'FlutterApp', // Nominatim requires a user-agent
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        setState(() {
          _suggestions = data
              .map<String>((item) =>
                  item['display_name'] as String) // full address string
              .toList();
        });
      } else {
        print("Error fetching locations: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching locations: $e");
    }
  }

  void _selectLocation(String location) {
    Navigator.pop(context, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search for a location",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: _fetchSuggestions,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final location = _suggestions[index];
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.redAccent),
                  title: Text(location),
                  onTap: () => _selectLocation(location),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
