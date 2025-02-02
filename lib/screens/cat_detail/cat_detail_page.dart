import 'package:cat_app/models/cat.dart';
import 'package:cat_app/screens/cat_detail/bloc/cat_detail_bloc.dart';
import 'package:cat_app/screens/cat_list/bloc/cat_list_bloc.dart';
import 'package:cat_app/widgets/cat_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatDetailPage extends StatelessWidget {
  const CatDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context)?.settings.arguments as Cat?;

    if (cat == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Cat Details")),
        body: const Center(child: Text("No cat data available.")),
      );
    }

    return BlocProvider(
      create: (context) => CatDetailBloc(
        cat: cat,
        catRepository: context.read(),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Cat Details")),
        body: BlocBuilder<CatDetailBloc, CatDetailState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Hero(
                    tag: 'cat_${state.cat.id}',
                    child: CatImageCard(
                      imageUrl: state.cat.url,
                      onPressed: () {
                        context.read<CatListBloc>().add(
                              OnToggleFavorite(cat: state.cat),
                            );
                      },
                      isFavorite: state.cat.isFavorite,
                      icon: state.cat.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: state.cat.isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Cat Fact'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(state.cat.fact,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
