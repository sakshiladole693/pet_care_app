import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_care_app/view/cart_screen.dart';
import 'package:pet_care_app/view/history_screen.dart';
import 'package:pet_care_app/view/home_screen.dart';
import 'package:pet_care_app/view/profile_screen.dart';
import 'package:pet_care_app/view/service_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ServiceScreen(),
    CartScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _selectTab(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // detect keyboard to hide FAB when typing
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 247, 1),
      // body shows current page, preserved by IndexedStack
      // body: IndexedStack(index: _selectedIndex, children: _pages),
      body: _pages[_selectedIndex],

      // fixed center FAB (always visible unless keyboard open)
      floatingActionButton: isKeyboardOpen
          ? null
          : GestureDetector(
              onTap: () {
                _selectTab(2); // center = Cart page
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 146, 69, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/cart.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Shop",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom bar with notch to accommodate FAB
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Home & Service
            Row(
              children: [
                _buildTabItem(
                  index: 0,
                  label: 'Home',
                  image: 'assets/svg/home.svg',
                ),
                _buildTabItem(
                  index: 1,
                  label: 'Service',
                  image: 'assets/svg/fav.svg',
                ),
              ],
            ),

            // Right side: History & Profile
            Row(
              children: [
                _buildTabItem(
                  index: 3,
                  label: 'History',
                  image: 'assets/svg/clock.svg',
                ),
                _buildTabItem(
                  index: 4,
                  label: 'Profile',
                  image: 'assets/svg/person.svg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String label,
    required String image,
  }) {
    final bool isSelected = _selectedIndex == index;
    final color = isSelected
        ? const Color.fromRGBO(245, 146, 69, 1)
        : const Color.fromRGBO(126, 128, 143, 1);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _selectTab(index),
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(icon, size: 26, color: color),
              SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
