import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/bloc/user/user_bloc.dart';
import 'package:flutter_application_1/domain/model/user/user_model.dart';
import 'package:flutter_application_1/feature/screen/user/userDetail_screen.dart';
import 'package:flutter_application_1/widget/user/manageUser.dart';
import 'package:flutter_application_1/widget/user/userItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(ReadUserEvent());
    super.initState();
  }

  void onModalBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => ManageUser(
        onSubmitCallback: onSubmit,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<UserBloc>().add(ReadUserEvent());
    });
  }

  Future<void> onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User App'),
        backgroundColor: Colors.blue,
      ),
      body: _buildBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onModalBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget get _buildBody {
    
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        debugPrint(state.toString());

      if (state is UserInitial ||
          state is UserLoadingState ||
          state is AddUserLoading ||
          state is DeleteUserLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is ReadUserState) {
        final users = state.userResponse;
        return _buildListview(users, context);
      } else {
        return const Text('empty');
      }
    });
  }

  Widget _buildListview(UserResponse users, BuildContext mContext) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(ReadUserEvent());
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            User user = users.info[index];
            return UserItem(mContext: mContext, user: user);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: users.info.length),
    );
  }
}
