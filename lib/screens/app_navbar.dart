import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:netflix/screens/homescreen.dart';

class AppNavbar extends StatefulWidget {
  const AppNavbar({super.key});

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 60,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Iconsax.home5), text: "Home"),
              Tab(icon: Icon(Iconsax.search_normal), text: "Search"),
              Tab(icon: Icon(Icons.photo_library_outlined), text: "Hot News"),
            ],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),
        body: TabBarView(children: [Homescreen(), Scaffold(), Scaffold()]),
      ),
    );
  }
}
