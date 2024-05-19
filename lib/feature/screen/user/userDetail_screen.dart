// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/domain/bloc/user/user_bloc.dart';
// import 'package:flutter_application_1/domain/model/client/client_model.dart';
// import 'package:flutter_application_1/widget/user/manageUser.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserDetailScreen extends StatefulWidget {
//   final User user;
//   const UserDetailScreen({required this.user, super.key});

//   @override
//   State<UserDetailScreen> createState() => _UserDetailScreenState();
// }

// class _UserDetailScreenState extends State<UserDetailScreen> {
//   @override
//   void initState() {
//     context.read<UserBloc>().add(ReadUserDetailEvent(id: widget.user.id));
//     super.initState();
//   }

//   Future<void> onSubmit() async {}

//   void onModalBottomSheet(BuildContext context, User user) async {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) => ManageUser(
//               onSubmitCallback: onSubmit,
//               user: user,
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('User detail'),
//           backgroundColor: Colors.blue,
//           leading: IconButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               context.read<UserBloc>().add(ReadUserEvent());
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//             ),
//           ),
//           actions: [
//             BlocBuilder<UserBloc, UserState>(
//               builder: (context, state) {
//                 if (state is ReadUserDetailState) {
//                   final _user = state.userDetailResponse.info;
//                   return IconButton(
//                       onPressed: () {
//                         onModalBottomSheet(context, _user);
//                       },
//                       icon: const Icon(Icons.edit));
//                 } else {
//                   return Container();
//                 }
//               },
//             )
//           ],
//         ),
//         body: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is ReadUserDetailLoading || state is UpdateUserLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is ReadUserDetailState) {
//               final _user = state.userDetailResponse.info;
//               return Center(
//                 child: Column(
//                   children: [Text('email : ${_user.email}')],
//                 ),
//               );
//             } else {
//               return const Center(
//                 child: Text('empty'),
//               );
//             }
//           },
//         ));
//   }
// }
