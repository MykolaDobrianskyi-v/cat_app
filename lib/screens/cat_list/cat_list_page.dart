import 'package:cat_app/screens/cat_list/bloc/cat_list_bloc.dart';
import 'package:cat_app/screens/cat_list/widgets/cat_list_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatListPage extends StatelessWidget {
  const CatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CAT LIST'),
        centerTitle: true,
      ),
      body: BlocBuilder<CatListBloc, CatListState>(
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
            child: CatListWidget(
              key: ValueKey('cats'),
              cats: state.cats,
              onScrolledToEnd: () => context.read<CatListBloc>().add(
                    OnLoadMore(),
                  ),
            ),
          );
        },
      ),
    );
  }
}
