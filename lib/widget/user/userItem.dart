// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_application_1/domain/bloc/user/user_bloc.dart';
// import 'package:flutter_application_1/domain/model/client/client_model.dart';
// import 'package:flutter_application_1/feature/screen/user/userDetail_screen.dart';

// class UserItem extends StatelessWidget {
//   final User user;
//   final BuildContext mContext;

//   const UserItem({required this.mContext, required this.user, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       background: Container(decoration: const BoxDecoration(color: Colors.red),),
//       direction: DismissDirection.endToStart,
//       onDismissed: (d) {
//         context
//             .read<UserBloc>()
//             .add(DeleteUserEvent(id: user.id, context: mContext));
//       },
//       key: ValueKey(user.id),
//       child: GestureDetector(
//         onTap: () async {
//           await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UserDetailScreen(user: user,),
//               ));
//         },
//         child: ListTile(
//           leading: const Icon(Icons.person),
//           title: Text(user.username),
//           subtitle: Text(user.email),
//           trailing: IconButton(
//             onPressed: () {
//               context
//                   .read<UserBloc>()
//                   .add(DeleteUserEvent(id: user.id, context: mContext));
//             },
//             icon: const Icon(Icons.delete),
//           ),
//         ),
//       ),
//     );
//   }
// }
