// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:mysen/core/constant.dart';
// import 'package:mysen/core/utiles.dart';

// class DescriptionsButton extends StatelessWidget {
//   const DescriptionsButton({super.key, });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.separated(
//         separatorBuilder: (context, index) =>
//             Divider(color: context.primaryContainer),
//         // itemCount: appointmentController.teethAdd.length,
//         itemCount: 2,
//         itemBuilder: (BuildContext context, int index) {
//           // final teeth = appointmentController.teethAdd[index];
//           return Row(
//             children: [
//               // Expanded(
//               //   flex: 3,
//               //   child: Text(style: context.bodyMeduim, teeth['description']),
//               // ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     FaIcon(
//                       size: context.mediaSize.shortestSide * .04,
//                       FontAwesomeIcons.tooth,
//                       color: whitecolor,
//                     ),
//                     // Text(style: context.bodyMeduim, teeth['number']),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
