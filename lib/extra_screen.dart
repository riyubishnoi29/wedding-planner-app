import 'package:flutter/material.dart';

class ExtrasScreen extends StatefulWidget {
  const ExtrasScreen({super.key});

  @override
  State<ExtrasScreen> createState() => _ExtrasScreenState();
}

class _ExtrasScreenState extends State<ExtrasScreen> {
  final TextEditingController _budgetController = TextEditingController();
  int? _budget;

  final List<Map<String, dynamic>> _guests = [];
  final TextEditingController _guestController = TextEditingController();

  void _calculateBudget() {
    if (_budgetController.text.isNotEmpty) {
      setState(() {
        _budget = int.tryParse(_budgetController.text.trim());
      });
    }
  }

  void _addGuest() {
    final guestName = _guestController.text.trim();
    if (guestName.isNotEmpty) {
      setState(() {
        _guests.add({"name": guestName, "status": "Pending"});
        _guestController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a guest name")),
      );
    }
  }

  void _updateRSVP(int index, String status) {
    setState(() {
      _guests[index]["status"] = status;
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Going":
        return Colors.green.shade600;
      case "Not Going":
        return Colors.redAccent;
      default:
        return Colors.orange.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // ✅ bottom nav ke peeche bhi gradient dikhega
      appBar: AppBar(
        title: const Text(
          "Wedding Essentials",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
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
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity, // ✅ gradient full screen cover karega
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade50,
              Colors.orange.shade50,
              Colors.pink.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 90, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 💰 Budget Section Card
              _buildBudgetSection(),

              const SizedBox(height: 24),

              // 👥 Guest List Section Card
              _buildGuestSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.pinkAccent.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "💰 Budget Calculator",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Wedding Budget",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                  onPressed: _calculateBudget,
                  child: const Text(
                    "Calculate",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_budget != null) ...[
              _buildBudgetCard("Venue", _budget! * 0.4, Icons.location_city, [
                Colors.pink.shade200,
                Colors.pink.shade400,
              ]),
              _buildBudgetCard("Catering", _budget! * 0.25, Icons.restaurant, [
                Colors.orange.shade200,
                Colors.deepOrange.shade300,
              ]),
              _buildBudgetCard(
                "Photography",
                _budget! * 0.15,
                Icons.photo_camera,
                [Colors.purple.shade200, Colors.purple],
              ),
              _buildBudgetCard(
                "Others",
                _budget! * 0.2,
                Icons.miscellaneous_services,
                [Colors.blue.shade200, Colors.blueAccent],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGuestSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.pinkAccent.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "👥 Guest List",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _guestController,
                    decoration: InputDecoration(
                      hintText: "Enter Guest Name",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: _addGuest,
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _guests.isEmpty
                ? const Text(
                    "No guests added yet.",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _guests.length,
                    itemBuilder: (context, index) {
                      final guest = _guests[index];
                      final name = guest["name"] ?? '';
                      final status = guest["status"] ?? 'Pending';

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.pink.shade50],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.pinkAccent.shade100,
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            "RSVP: $status",
                            style: TextStyle(
                              color: _getStatusColor(status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) => _updateRSVP(index, value),
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: "Going",
                                child: Text("✅ Going"),
                              ),
                              PopupMenuItem(
                                value: "Not Going",
                                child: Text("❌ Not Going"),
                              ),
                              PopupMenuItem(
                                value: "Pending",
                                child: Text("⏳ Pending"),
                              ),
                            ],
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard(
    String title,
    double amount,
    IconData icon,
    List<Color> colors,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: Icon(icon, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "₹${amount.toInt()}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
