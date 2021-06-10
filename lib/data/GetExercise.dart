// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class GetUserName extends StatelessWidget {
//   final String documentId;
//
//   GetUserName(this.documentId);
//
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Exercise')
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           return ListView.builder(
//             itemCount: streamSnapshot.data!.docs.length,
//             itemBuilder: (ctx, index) =>
//                 Text(streamSnapshot.data!.docs[index]['text']),
//           );
//         },
//       )
//     );
//   }
// }