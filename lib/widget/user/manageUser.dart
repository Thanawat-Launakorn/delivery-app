// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_application_1/domain/bloc/user/user_bloc.dart';
// import 'package:flutter_application_1/domain/model/client/client_model.dart';

// class ManageUser extends StatefulWidget {
//   final Future<void> Function() onSubmitCallback;
//   final User? user;
//   const ManageUser({this.user, required this.onSubmitCallback, super.key});

//   @override
//   State<ManageUser> createState() => _ManageUserState();
// }

// class _ManageUserState extends State<ManageUser> {
//   late final TextEditingController _username;
//   late final TextEditingController _email;

//   @override
//   void initState() {
//     _username = TextEditingController(text: widget.user?.username ?? '');
//     _email = TextEditingController(text: widget.user?.email ?? '');
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _email.dispose();
//     _username.dispose();
//     super.dispose();
//   }

//   Future<void> onSubmit(BuildContext context) async {
//     if (widget.user != null) {
//       context.read<UserBloc>().add(UpdateUserEvent(
//           id: widget.user!.id,
//           username: _username.text,
//           email: _email.text,
//           context: context));
//     } else {
//       context.read<UserBloc>().add(AddUserEvent(
//           username: _username.text, email: _email.text, context: context));
//       await widget.onSubmitCallback();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12, 12, 12, 40),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _email,
//             decoration: InputDecoration(hintText: 'email'),
//           ),
//           TextField(
//             controller: _username,
//             decoration: InputDecoration(hintText: 'username'),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           OutlinedButton(onPressed: () {
//             onSubmit(context);
//           }, child: BlocBuilder<UserBloc, UserState>(
//             builder: (context, state) {
//               if (state is AddUserLoading) {
//                 bool isLoading = state.isLoading;
//                 return isLoading
//                     ? CircularProgressIndicator()
//                     : Text("Add user");
//               } else {
//                 return const Text('Add user');
//               }
//             },
//           ))
//         ],
//       ),
//     );
//   }
// }
