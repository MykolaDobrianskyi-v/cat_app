import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/cat_list/bloc/cat_list_bloc.dart';
import 'package:cat_app/widgets/cat_image_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatListWidget extends StatefulWidget {
  final List<Cat> cats;
  final VoidCallback onScrolledToEnd;

  const CatListWidget({
    super.key,
    required this.cats,
    required this.onScrolledToEnd,
  });

  @override
  State<CatListWidget> createState() => _CatListWidgetState();
}

class _CatListWidgetState extends State<CatListWidget> {
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
      create: (context) => CatListBloc(
        catRepository: context.read(),
      ),
      child: BlocBuilder<CatListBloc, CatListState>(
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
              onPressed: () {
                context.read<CatListBloc>().add(
                      OnAddToFavorite(cat: widget.cats[index]),
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
