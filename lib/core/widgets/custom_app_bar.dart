import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.15),
      leading: showBackButton 
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryBlue),
              onPressed: () => Navigator.pop(context),
            )
          : Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.primaryBlue),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 64,
            errorBuilder: (context, error, stackTrace) {
              return Text(
                'Sipena',
                style: GoogleFonts.inter(
                  color: AppColors.secondaryOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF002369),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
