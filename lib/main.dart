import 'package:flutter/material.dart';
import 'package:wedding_planner_app/checklist_screen.dart';
import 'package:wedding_planner_app/extra_screen.dart';
import 'package:wedding_planner_app/screens/splash_screen.dart';
import 'package:wedding_planner_app/venue_screen.dart';

void main() {
  runApp(const WeddingPlannerApp());
}

class WeddingPlannerApp extends StatelessWidget {
  const WeddingPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plan Your Wedding with Us 💍',
      theme: ThemeData(primaryColor: Colors.pinkAccent, fontFamily: 'Roboto'),
      home: const SplashScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(
          context,
        ).size.height, // 👈 pura screen cover karega
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(
                  context,
                ).size.height, // 👈 ensure kare full height
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.favorite,
                      size: 80,
                      color: Colors.pinkAccent,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Plan Your Dream Wedding 💍",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Login/Register Switcher
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isLogin = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isLogin
                                      ? Colors.pinkAccent
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: isLogin
                                      ? [
                                          BoxShadow(
                                            color: Colors.pinkAccent
                                                .withOpacity(0.5),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : [],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: isLogin
                                        ? Colors.white
                                        : Colors.pinkAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isLogin = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !isLogin
                                      ? Colors.purpleAccent
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: !isLogin
                                      ? [
                                          BoxShadow(
                                            color: Colors.purpleAccent
                                                .withOpacity(0.5),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : [],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: !isLogin
                                        ? Colors.white
                                        : Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Input Fields Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          if (!isLogin)
                            buildTextField(Icons.person, "Full Name"),
                          buildTextField(Icons.email, "Email"),
                          if (!isLogin)
                            buildTextField(Icons.phone, "Phone Number"),
                          buildTextField(
                            Icons.lock,
                            "Password",
                            isPassword: true,
                          ),
                          if (!isLogin)
                            buildTextField(
                              Icons.lock,
                              "Confirm Password",
                              isPassword: true,
                            ),
                          const SizedBox(height: 20),

                          // Gradient Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.pinkAccent,
                                  Colors.purpleAccent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                isLogin ? "Login" : "Register",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String hint, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.pinkAccent),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ChecklistScreen(),
    const VenueScreen(),
    const ExtrasScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Checklist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: "Venues",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "Extras",
          ),
        ],
      ),
    );
  }
}
