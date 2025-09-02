import 'package:flutter/material.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({super.key});

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  final List<Map<String, dynamic>> _venues = [
    {
      "name": "Royal Palace",
      "location": "Delhi",
      "price": 200000,
      "capacity": 500,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRqIqlYVY6e3NgoMCMcs19_-BYbxzTVtFQTg&s",
    },
    {
      "name": "Sunset Garden",
      "location": "Jaipur",
      "price": 150000,
      "capacity": 300,
      "image":
          "https://images.pexels.com/photos/29624022/pexels-photo-29624022.jpeg",
    },
    {
      "name": "Ocean View Resort",
      "location": "Goa",
      "price": 300000,
      "capacity": 600,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7cpdq8rk1vps6Ix6r2FXT2BZNaLFMjImqBg&s",
    },
    {
      "name": "Grand Heritage Hotel",
      "location": "Udaipur",
      "price": 250000,
      "capacity": 450,
      "image":
          "https://media.weddingz.in/photologue/images/opera-gardens-and-banquets-opera-gardens-and-banquets-hall.jpg",
    },
    {
      "name": "Golden Leaf Banquet",
      "location": "Mumbai",
      "price": 180000,
      "capacity": 350,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY8RFCUC_20EBzpkAjMDZmgMNJfKW442274Q&s",
    },
  ];

  int? _selectedBudget;
  int? _selectedCapacity;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredVenues = _venues.where((venue) {
      bool matchesBudget =
          _selectedBudget == null || venue["price"] <= _selectedBudget!;
      bool matchesCapacity =
          _selectedCapacity == null || venue["capacity"] >= _selectedCapacity!;
      return matchesBudget && matchesCapacity;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          "Wedding Venues",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 6,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedBudget,
                    isExpanded: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.pinkAccent,
                      ),
                      hintText: "Max Budget",
                      labelStyle: const TextStyle(color: Colors.pinkAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                    ),
                    items: [150000, 200000, 250000, 300000]
                        .map(
                          (budget) => DropdownMenuItem(
                            value: budget,
                            child: Text("₹$budget"),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBudget = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedCapacity,
                    isExpanded: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.people_alt_outlined,
                        color: Colors.pinkAccent,
                      ),
                      hintText: "Min Capacity",
                      labelStyle: const TextStyle(color: Colors.pinkAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                    ),
                    items: [200, 300, 400, 500]
                        .map(
                          (cap) => DropdownMenuItem(
                            value: cap,
                            child: Text("$cap+ Guests"),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCapacity = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // ✅ Venue List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredVenues.length,
              itemBuilder: (context, index) {
                final venue = filteredVenues[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shadowColor: Colors.pinkAccent.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                        child: Image.network(
                          venue["image"],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.broken_image,
                                size: 60,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venue["name"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  venue["location"],
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${venue["price"]}",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${venue["capacity"]} guests",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
