// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:stories_app/core/utils/app_colors.dart';
// import 'package:stories_app/core/widgets/my_text.dart';
// import 'package:stories_app/features/home/views/manager/progress_loading/progress_loading_cubit.dart';

// class ItemProgressWidget extends StatelessWidget {
//   const ItemProgressWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         LinearPercentIndicator(
//           lineHeight: 14.0,
//           barRadius: Radius.circular(8),
//           percent: ProgressLoadingCubit.get(context).progressString,
//           backgroundColor: Colors.grey,
//           progressColor: AppColors.BASE_COLOR,
//         ),
//         Positioned(
//           top: 0,
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: MyText(
//             title: (ProgressLoadingCubit.get(context).progressString * 100)
//                     .toStringAsFixed(0) +
//                 "%",
//             textAlign: TextAlign.center,
//             fontSize: 10,
//             fontWeight: FontWeight.bold,
//             color: AppColors.WHITE,
//             height: 1,
//           ),
//         )
//       ],
//     );
//   }
// }
