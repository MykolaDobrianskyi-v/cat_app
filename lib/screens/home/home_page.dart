import 'package:cat_app/screens/cat_list/cat_list_page.dart';
import 'package:cat_app/screens/favorite/favorites_page.dart';
import 'package:cat_app/screens/home/bloc/home_bloc.dart';
import 'package:cat_app/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const CatListPage(),
      const FavoritesPage(),
      const ProfilePage(),
    ];

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: pages[state.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (value) =>
                  context.read<HomeBloc>().add(OnChangeTab(value)),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
