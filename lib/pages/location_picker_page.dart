
import 'package:flutter/material.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({Key? key}) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allLocations = [
    "Gulberg Phase 4, Lahore",
    "Model Town, Lahore",
    "DHA Phase 5, Lahore",
    "Johar Town, Lahore",
    "Bahria Town, Lahore",
    "Cantt, Lahore",
    "Wapda Town, Lahore",
    "Faisal Town, Lahore",
  ];

  List<String> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _filteredLocations = _allLocations;
  }

  void _filterLocations(String query) {
    setState(() {
      _filteredLocations = _allLocations
          .where((loc) => loc.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
              onChanged: _filterLocations,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLocations.length,
              itemBuilder: (context, index) {
                final location = _filteredLocations[index];
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
