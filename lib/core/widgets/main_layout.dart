
import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/jurnal/presentation/pages/jurnal_mengajar_page.dart';
import '../../features/absen/presentation/pages/absensi_page.dart';
import '../../core/constants/colors.dart';
import 'custom_drawer.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final GlobalKey<NavigatorState> _jurnalNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _absenNavigatorKey =
      GlobalKey<NavigatorState>();

  late final List<Widget> _pages = [
    const DashboardPage(),

    Navigator(
      key: _jurnalNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) =>
              const JurnalMengajarPage(),
        );
      },
    ),

    Navigator(
      key: _absenNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => AbsensiPage(),
        );
      },
    ),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      if (index == 1) {
        _jurnalNavigatorKey.currentState
            ?.popUntil((route) => route.isFirst);
      } else if (index == 2) {
        _absenNavigatorKey.currentState
            ?.popUntil((route) => route.isFirst);
      }
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            activeIcon: Icon(Icons.book),
            label: 'Jurnal',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            activeIcon: Icon(Icons.fact_check),
            label: 'Absen',
          ),
        ],

        currentIndex: _selectedIndex,

        selectedItemColor:
            AppColors.primaryBlue,

        unselectedItemColor:
            AppColors.textSecondary,

        onTap: _onItemTapped,

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.white,

        elevation: 16,
      ),
    );
  }
}