import 'package:cat_app/screens/login/bloc/login_bloc.dart';
import 'package:cat_app/screens/profile/bloc/profile_bloc.dart';
import 'package:cat_app/screens/profile/widget/profile_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            centerTitle: true,
          ),
          body: ProfileCardWidget(
            image: state.user?.image,
            username: state.user?.username,
            email: state.user?.email,
            onPressed: () {
              context.read<LoginBloc>().add(OnSignOut());
            },
          ),
        );
      },
    );
  }
}
