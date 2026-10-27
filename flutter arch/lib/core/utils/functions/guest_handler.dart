// import 'package:flutter/material.dart';
// import '../../../config/router/app_router_keys.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_enums.dart';
// import '../constants/app_strings.dart';
// import '../constants/storage_keys.dart';
// import 'responsive.dart';
// import 'router_handler.dart';
// import 'shared_preferance_utils.dart';

// bool isGuestUser() {
//   return PreferenceUtils.getBool(StorageKeys.isGuest);
// }

// void showLoginRequiredDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     useRootNavigator: true,
//     barrierColor: AppColors.darkColor.withValues(alpha: 0.55),
//     builder: (ctx) => Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       insetPadding: EdgeInsets.symmetric(horizontal: 28.width),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.whiteColor,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.darkColor.withValues(alpha: 0.12),
//               blurRadius: 32,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // ── gradient header ──────────────────────────────
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 28.height),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF329AAB), Color(0xFF1974BB)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 68,
//                     height: 68,
//                     decoration: BoxDecoration(
//                       color: AppColors.whiteColor.withValues(alpha: 0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.lock_outline_rounded,
//                       color: AppColors.whiteColor,
//                       size: 34,
//                     ),
//                   ),
//                   SizedBox(height: 12.height),
//                   Text(
//                     AppStrings.loginRequired,
//                     style: TextStyle(
//                       fontSize: 20.fontSize,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.whiteColor,
//                       letterSpacing: 0.3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // ── body ─────────────────────────────────────────
//             Padding(
//               padding: EdgeInsets.fromLTRB(24.width, 20.height, 24.width, 8.height),
//               child: Text(
//                 AppStrings.mustLoginToUseFeature,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14.fontSize,
//                   color: AppColors.slate500,
//                   height: 1.55,
//                 ),
//               ),
//             ),

//             // ── buttons ───────────────────────────────────────
//             Padding(
//               padding: EdgeInsets.fromLTRB(20.width, 12.height, 20.width, 24.height),
//               child: Row(
//                 children: [
//                   // Cancel
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => RouterHandler.pop(ctx),
//                       style: OutlinedButton.styleFrom(
//                         foregroundColor: AppColors.primaryColor,
//                         side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 14.height),
//                       ),
//                       child: Text(
//                         AppStrings.cancel,
//                         style: TextStyle(
//                           fontSize: 14.fontSize,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 12.width),
//                   // Sign In
//                   Expanded(
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF329AAB), Color(0xFF1974BB)],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           RouterHandler.pop(ctx);
//                           RouterHandler.navigate(
//                             context,
//                             AppRouterKeys.login,
//                             routerType: RouterType.pushReplacementNamed,
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           foregroundColor: AppColors.whiteColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 14.height),
//                         ),
//                         child: Text(
//                           AppStrings.signIn,
//                           style: TextStyle(
//                             fontSize: 14.fontSize,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
