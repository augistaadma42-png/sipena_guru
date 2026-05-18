
// import 'package:flutter/material.dart';
// import '../../features/dashboard/presentation/pages/dashboard_page.dart';
// import '../../features/jurnal/presentation/pages/jurnal_mengajar_page.dart';
// import '../../features/absen/presentation/pages/absensi_page.dart';
// import '../../features/tugas/dashboard_tugas/presentation/pages/dashboard_tugas_page.dart';
// import '../../features/laporan/dashboard/presentation/pages/dashboard_page.dart'as laporan;
// import '../../core/constants/colors.dart';
// import 'custom_drawer.dart';

// class MainLayout extends StatefulWidget {
//   const MainLayout({Key? key}) : super(key: key);

//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   int _selectedIndex = 0;
//   final GlobalKey<NavigatorState> _jurnalNavigatorKey = GlobalKey<NavigatorState>();
//   final GlobalKey<NavigatorState> _absenNavigatorKey = GlobalKey<NavigatorState>();
//   final GlobalKey<NavigatorState> _tugasNavigatorKey = GlobalKey<NavigatorState>();
//   final GlobalKey<NavigatorState> _laporanNavigatorKey = GlobalKey<NavigatorState>();

//   final GlobalKey<NavigatorState> _jurnalNavigatorKey =
//       GlobalKey<NavigatorState>();

//   final GlobalKey<NavigatorState> _absenNavigatorKey =
//       GlobalKey<NavigatorState>();

//   late final List<Widget> _pages = [
//     const DashboardPage(),

//     Navigator(
//       key: _jurnalNavigatorKey,
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) =>
//               const JurnalMengajarPage(),
//         );
//       },
//     ),

//     Navigator(
//       key: _absenNavigatorKey,
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) => AbsensiPage(),
//         );
//       },
//     ),
//     Navigator(
//       key: _tugasNavigatorKey,
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) => const DashboardTugasPage(),
//         );
//       },
//     ),
//     Navigator(
//       key: _laporanNavigatorKey,
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) => const laporan.DashboardPage(),
//         );
//       },
//     ),
//   ];

//   void _onItemTapped(int index) {
//     if (_selectedIndex == index) {
//       if (index == 1) {
//         _jurnalNavigatorKey.currentState
//             ?.popUntil((route) => route.isFirst);
//       } else if (index == 2) {
//         _absenNavigatorKey.currentState?.popUntil((route) => route.isFirst);
//       } else if (index == 3) {
//         _tugasNavigatorKey.currentState?.popUntil((route) => route.isFirst);
//       } else if (index == 4) {
//         _laporanNavigatorKey.currentState?.popUntil((route) => route.isFirst);
//         _absenNavigatorKey.currentState
//             ?.popUntil((route) => route.isFirst);
//       }
//     }

//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const CustomDrawer(),

//       body: _pages[_selectedIndex],

//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home),
//             label: 'Home',
//           ),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_outlined),
//             activeIcon: Icon(Icons.book),
//             label: 'Jurnal',
//           ),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.fact_check_outlined),
//             activeIcon: Icon(Icons.fact_check),
//             label: 'Absen',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu_book_outlined),
//             activeIcon: Icon(Icons.menu_book),
//             label: 'Tugas',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assessment_outlined),
//             activeIcon: Icon(Icons.assessment),
//             label: 'Laporan',
//           ),
//         ],

//         currentIndex: _selectedIndex,

//         selectedItemColor:
//             AppColors.primaryBlue,

//         unselectedItemColor:
//             AppColors.textSecondary,

//         onTap: _onItemTapped,

//         type: BottomNavigationBarType.fixed,

//         backgroundColor: Colors.white,

//         elevation: 16,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/jurnal/presentation/pages/jurnal_mengajar_page.dart';
import '../../features/absen/presentation/pages/absensi_page.dart';
import '../../features/tugas/dashboard_tugas/presentation/pages/dashboard_tugas_page.dart';
import '../../features/laporan/dashboard/presentation/pages/dashboard_page.dart'
    as laporan;
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

  final GlobalKey<NavigatorState> _tugasNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _laporanNavigatorKey =
      GlobalKey<NavigatorState>();

  late final List<Widget> _pages = [
    const DashboardPage(),

    Navigator(
      key: _jurnalNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const JurnalMengajarPage(),
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

    Navigator(
      key: _tugasNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const DashboardTugasPage(),
        );
      },
    ),

    Navigator(
      key: _laporanNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const laporan.DashboardPage(),
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
      } else if (index == 3) {
        _tugasNavigatorKey.currentState
            ?.popUntil((route) => route.isFirst);
      } else if (index == 4) {
        _laporanNavigatorKey.currentState
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

          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Tugas',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            activeIcon: Icon(Icons.assessment),
            label: 'Laporan',
          ),
        ],

        currentIndex: _selectedIndex,

        selectedItemColor: AppColors.primaryBlue,

        unselectedItemColor: AppColors.textSecondary,

        onTap: _onItemTapped,

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.white,

        elevation: 16,
      ),
    );
  }
}