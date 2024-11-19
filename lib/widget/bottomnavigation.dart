import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../favorite_view/favorite_view.dart';
import '../home_view/home_view.dart';
import 'BottomNavigationProvider.dart';

class Bottomnavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavigationProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<BottomNavigationProvider>(
            builder: (context, provider, _) {
              return Text(
                provider.currentIndex == 0 ? '' : '',
                style: TextStyle(color: Colors.white), // AppBar text color
              );
            },
          ),
        ),
        body: Consumer<BottomNavigationProvider>(
          builder: (context, provider, _) {
            return IndexedStack(
              index: provider.currentIndex,
              children: [
                HomeView(),
                FavoriteView(),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationProvider>(
          builder: (context, provider, _) {
            return BottomNavigationBar(
              currentIndex: provider.currentIndex,
              onTap: provider.setIndex,
              selectedItemColor: Color(0xFFDB3022), // Red color for selected item
              unselectedItemColor: Color(0xFF9B9B9B), // Gray color for unselected items
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ],
              selectedLabelStyle: TextStyle(
                color: Color(0xFFDB3022),
              ),
              unselectedLabelStyle: TextStyle(
                color: Color(0xFF9B9B9B),
              ),
            );
          },
        ),
      ),
    );
  }
}
