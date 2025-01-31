import 'package:cat_app/screens/favorite/bloc/favorite_cats_bloc.dart';
import 'package:cat_app/screens/favorite/widget/favorite_cats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAVORITE CATS'), centerTitle: true),
      body: BlocBuilder<FavoriteCatsBloc, FavoriteCatsState>(
        builder: (context, state) {
          print('UPDATED CATS!!!!!!!!!!!!!! ${state.favCats}');
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amber));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 60),
            child: FavoriteCatsListWidget(
              cats: state.favCats,
              onScrolledToEnd: () {},
            ),
          );
        },
      ),
    );
  }
}
