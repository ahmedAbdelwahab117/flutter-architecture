// import 'package:enhanced_paginated_view/enhanced_paginated_view.dart';
// import 'package:flutter/material.dart';
//
// import '../utils/constant/app_enums.dart';
// import '../utils/functions/responsive.dart';
//
// class PaginationView extends StatelessWidget {
//   const PaginationView({
//     super.key,
//     this.mainAxisExtent,
//     required this.pageSize,
//     this.isListView = false,
//     required this.items,
//     required this.itemBuilder,
//     required this.requestStatus,
//     required this.hasReachedMax,
//     required this.onLoadMore,
//     this.countItemInRow = 2,
//     this.paddingBottom = 8,
//     this.onRefresh,
//     this.header,
//     this.emptyMessage,
//   });
//   final int countItemInRow;
//   final RequestStatus requestStatus;
//   final List items;
//   final int pageSize;
//   final int paddingBottom;
//   final double? mainAxisExtent;
//   final bool hasReachedMax;
//   final bool isListView;
//   final Widget? Function(BuildContext context, int index) itemBuilder;
//   final Function(int page) onLoadMore;
//   final Future<void> Function()? onRefresh;
//
//   /// Scrolls together with the items, above the first one.
//   final Widget? header;
//
//   /// Shown under [header] when [items] is empty.
//   final String? emptyMessage;
//
//   @override
//   Widget build(BuildContext context) {
//     final EnhancedStatus status = getStatus();
//     return EnhancedPaginatedView(
//       onLoadMore: onLoadMore,
//       onRefresh: onRefresh,
//       refreshBuilder: (context, onRefreshCallback, child) {
//         return RefreshIndicator(
//           color: Colors.white,
//           backgroundColor: const Color(0xFF0D6B47),
//           onRefresh: onRefreshCallback,
//           child: child,
//         );
//       },
//       itemsPerPage: pageSize,
//       delegate: EnhancedDelegate(
//         listOfData: items,
//         status: status,
//         header: header,
//         crossAxisAlignment: header == null
//             ? CrossAxisAlignment.center
//             : CrossAxisAlignment.stretch,
//         emptyWidgetConfig: emptyMessage == null
//             ? const EmptyWidgetConfig()
//             : EmptyWidgetConfig(title: emptyMessage!),
//       ),
//       builder: (items, physics, reverse, shrinkWrap) {
//         return isListView
//             ? ListView.builder(
//                 padding: EdgeInsets.only(
//                   left: 10.width,
//                   right: 10.width,
//                   bottom:
//                       paddingBottom.height +
//                       paddingBottom +
//                       MediaQuery.paddingOf(context).bottom,
//                 ),
//                 itemCount: items.length,
//
//                 physics: physics,
//                 reverse: reverse,
//                 shrinkWrap: shrinkWrap,
//                 itemBuilder: itemBuilder,
//               )
//             : GridView.builder(
//                 padding: EdgeInsets.only(
//                   left: 10.width,
//                   right: 10.width,
//                   bottom:
//                       paddingBottom.height +
//                       MediaQuery.paddingOf(context).bottom,
//                 ),
//                 itemCount: items.length,
//                 physics: physics,
//                 reverse: reverse,
//                 shrinkWrap: shrinkWrap,
//                 itemBuilder: itemBuilder,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   mainAxisExtent: mainAxisExtent,
//                   crossAxisCount: context.isTablet ? 2 : countItemInRow,
//                 ),
//               );
//       },
//       hasReachedMax: hasReachedMax,
//     );
//   }
//
//   EnhancedStatus getStatus() {
//     switch (requestStatus) {
//       case RequestStatus.loading:
//         return EnhancedStatus.loading;
//       case RequestStatus.success:
//         return EnhancedStatus.loaded;
//       case RequestStatus.failed:
//         return EnhancedStatus.error;
//       default:
//         return EnhancedStatus.loaded;
//     }
//   }
// }
