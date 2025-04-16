import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  

  const MyAppBar({
    super.key, 
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.redAccent,
      title: Text(
        title,
        style: GoogleFonts.sacramento(
          fontSize: 33,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: showBackButton 
        ? IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: Icon(Icons.chevron_left, color: Colors.white),
          )
        : null,
      elevation: 4, 
      centerTitle: true,
    );
  }
    @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}