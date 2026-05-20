
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
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/jurnal/presentation/pages/jurnal_mengajar_page.dart';
import '../../features/absen/presentation/pages/absensi_page.dart';
import '../../features/tugas/daftar_kelas/presentation/pages/daftar_kelas_page.dart';
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
  DateTime? _lastPressedAt;

  final GlobalKey<NavigatorState> _jurnalNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _absenNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _tugasNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _laporanNavigatorKey =
      GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState>? get _currentTabNavigatorKey {
    switch (_selectedIndex) {
      case 1:
        return _jurnalNavigatorKey;
      case 2:
        return _absenNavigatorKey;
      case 3:
        return _tugasNavigatorKey;
      case 4:
        return _laporanNavigatorKey;
      default:
        return null;
    }
  }

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
          builder: (context) => const DaftarKelasPage(),
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

  Future<void> _handleBackPress() async {
    final currentKey = _currentTabNavigatorKey;

    // 1. Jika masih ada halaman sebelumnya di nested navigator tab saat ini,
    // lakukan pop pada navigator tersebut.
    if (currentKey != null &&
        currentKey.currentState != null &&
        currentKey.currentState!.canPop()) {
      currentKey.currentState!.pop();
      return;
    }

    // 2. Jika berada di tab lain selain dashboard (index != 0) dan tidak ada halaman
    // sebelumnya di tab tersebut, kembali ke tab dashboard (index 0).
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return;
    }

    // 3. Jika berada di halaman utama/dashboard (index == 0) dan tidak ada halaman sebelumnya,
    // jalankan logic 2x tekan tombol back untuk keluar.
    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tekan sekali lagi untuk keluar',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          backgroundColor: AppColors.primaryBlue,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      await SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleBackPress();
      },
      child: Scaffold(
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
      ),
    );
  }
}