import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/favorite/bloc/favorite_cats_bloc.dart';
import 'package:cat_app/widgets/cat_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCatsListWidget extends StatefulWidget {
  final List<Cat> cats;
  final VoidCallback onScrolledToEnd;
  const FavoriteCatsListWidget({
    super.key,
    required this.onScrolledToEnd,
    required this.cats,
  });

  @override
  State<FavoriteCatsListWidget> createState() => _FavoriteCatsListWidgetState();
}

class _FavoriteCatsListWidgetState extends State<FavoriteCatsListWidget> {
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
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      controller: scrollController,
      itemCount: widget.cats.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      itemBuilder: (context, index) => CatImageCard(
        key: ValueKey(widget.cats[index].id),
        icon: widget.cats[index].isFavorite
            ? Icons.favorite
            : Icons.favorite_border,
        color: widget.cats[index].isFavorite ? Colors.red : Colors.grey,
        isFavorite: widget.cats[index].isFavorite,
        imageUrl: widget.cats[index].url,
        onPressed: () {
          final catBloc = context.read<FavoriteCatsBloc>();
          catBloc.add(OnToggleFavorite(cat: widget.cats[index]));
        },
      ),
    );
  }
}
