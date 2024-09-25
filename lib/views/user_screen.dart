import 'package:as_demo/app_constant/AppStringConstants.dart';
import 'package:as_demo/views/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user_bloc.dart';
import '../events/user_event.dart';
import '../models/user_model.dart';
import '../states/user_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc _userBloc;
  List<User> _users = [];
  bool isLoading = true;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    _userBloc.add(LoadUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStringConstants.appName),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            isLoading = true;
          } else if (state is UserLoaded) {
            _users = state.users;



            isLoading = false;
          } else if (state is UserError) {
            isLoading = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorDialog(context,AppStringConstants.errorMsg, state.message);
            });

          }
          return _buildUI();
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
          visible: (_users.isNotEmpty),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return UserProfileCard(
                  name: user.name ?? '',
                  avatarUrl: user.avatar ?? '',
                  createdAt: user.createdAt ?? '',
                  userId: user.id ?? '',
                );
              },
            ),
          ),
        ),
        Visibility(
            visible: isLoading,
            child: const Center(
              child: CircularProgressIndicator(),
            ))
      ],
    );
  }

  Future<void> _refreshData() async {
    _userBloc.emit(UserInitial());
    _userBloc.add(LoadUserEvent());
  }
}
