import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/favorite/bloc/favorite_cats_bloc.dart';
import 'package:cat_app/widgets/cat_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  final List<Cat> cats;
  final VoidCallback onScrolledToEnd;
  const FavoritesPage({
    super.key,
    required this.onScrolledToEnd,
    required this.cats,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.onScrolledToEnd();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCatsBloc(
        catRepository: context.read(),
      ),
      child: BlocBuilder<FavoriteCatsBloc, FavoriteCatsState>(
        builder: (context, state) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            controller: scrollController,
            itemCount: widget.cats.length,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            itemBuilder: (context, index) => CatImageCard(
              imageUrl: widget.cats[index].url,
              onPressed: () => context
                  .read<FavoriteCatsBloc>()
                  .add(OnAddToFavorite(cats: state.favCats)),
            ),
          );
        },
      ),
    );
  }
}
