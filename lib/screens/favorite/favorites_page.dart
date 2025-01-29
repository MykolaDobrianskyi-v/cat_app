import 'package:cat_app/screens/cat_list/widgets/cat_list_widget.dart';
import 'package:cat_app/screens/favorite/bloc/favorite_cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCatsBloc(
        catRepository: context.read(),
      ),
      child: BlocBuilder<FavoriteCatsBloc, FavoriteCatsState>(
        builder: (context, state) {
          if (state.isLoading ?? false) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 60),
            child: CatListWidget(cats: state.favCats, onScrolledToEnd: () {}),
          );
        },
      ),
    );
  }
}
