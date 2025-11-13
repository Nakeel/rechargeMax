// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recharge_max/common/widgets/naira_richtext_widget.dart';
// import 'package:recharge_max/common/widgets/widgets.dart';
// import 'package:recharge_max/core/constants/app_string_constants.dart';
// import 'package:recharge_max/core/ui/app_theme.dart';
// import 'package:recharge_max/core/ui/colors.dart';
// import 'package:recharge_max/core/utils/util.dart';
// import 'package:recharge_max/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:recharge_max/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:recharge_max/features/products/domain/entity/product_item_entity.dart';
//
// class ProductItemWidget extends StatefulWidget {
//   final String imageUrl;
//   final String productName;
//   final int? oldPrice;
//   final int? percentageOff;
//   final Function()? onTap;
//   final ProductItemEntity product;
//
//   const ProductItemWidget(
//       {super.key,
//       required this.product,
//       required this.imageUrl,
//       required this.productName,
//       this.oldPrice,
//       this.percentageOff,
//       this.onTap});
//
//   @override
//   _ProductItemWidgetState createState() => _ProductItemWidgetState();
// }
//
// class _ProductItemWidgetState extends State<ProductItemWidget> {
//   final GlobalKey _key = GlobalKey();
//   final AutoSizeGroup _priceGroup = AutoSizeGroup();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         final pricePerMon = !state.isEligible
//             ? widget.product.product?.defaultMonthlyPayment
//             : widget.product.monthlyRepayment;
//         return InkWell(
//           onTap: widget.onTap,
//           child: Container(
//             key: _key, // Assign GlobalKey to the widget
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.colorWhite,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.lightGrey,
//                   spreadRadius: 6,
//                   blurRadius: 6,
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//                     ProductImageCardWidget(
//                       image: widget.imageUrl,
//                       height: 100,
//                       width: 100,
//                       containerWidth: double.infinity,
//                     ),
//                     // Positioned(
//                     //   top: 13,
//                     //   left: 10,
//                     //   child: Container(
//                     //     decoration: BoxDecoration(
//                     //       borderRadius: BorderRadius.circular(4),
//                     //       color: Colors.green,
//                     //     ),
//                     //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     //     child: const TextView(
//                     //       text: 'Best Seller',
//                     //       fontWeight: FontWeight.w400,
//                     //       fontSize: 10,
//                     //       color: AppColors.colorWhite,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Title + Percentage off
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     double titleWidth = constraints.maxWidth * 0.7;
//                     double discountWidth = constraints.maxWidth * 0.25;
//
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: titleWidth,
//                           child: AutoSizeText(
//                             widget.productName,
//                             minFontSize: 10,
//                             maxLines: 2,
//                             maxFontSize: 12,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         if (widget.percentageOff != null)
//                           SizedBox(
//                             width: discountWidth,
//                             child: Align(
//                               alignment: Alignment.topRight,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 4, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.shade100,
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: AutoSizeText(
//                                   '${widget.percentageOff}% off',
//                                   maxFontSize: 10,
//                                   maxLines: 1,
//                                   minFontSize: 7,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 10),
//
//                 // Price and Old Price
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     double priceWidth = constraints.maxWidth * 0.7;
//                     double oldPriceWidth = constraints.maxWidth * 0.25;
//
//                     return SizedBox(
//                       width: constraints.maxWidth,
//                       child: Row(
//                         children: [
//                           AutoSizeText.rich(
//                             TextSpan(
//                               text:
//                                   '${AppConstants.nairaSymbol} ${Util.formatCurrency((pricePerMon ?? 0))}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontFamily: AppTheme.roboto,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.colorBlack,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: '/mo',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: AppTheme.geist,
//                                     color: AppColors.hintGrey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             group: _priceGroup,
//                             minFontSize: 8,
//                             maxFontSize: 14,
//                             maxLines: 1,
//                           ),
//                           if (widget.oldPrice != null) ...[
//                             const SizedBox(width: 8),
//                             NairaRichText(
//                               value: Util.formatCurrency(widget.oldPrice ?? 0),
//                               symbolStyle: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 10,
//                                 color: AppColors.hintGrey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                               minFontSize: 7,
//                               valueStyle: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.hintGrey,
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                           ]
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Measure width dynamically after layout is complete
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
//       if (renderBox != null) {
//         final width = renderBox.size.width;
//         // You can now use the width dynamically after layout is complete
//         print('Widget Width: $width');
//       }
//     });
//   }
// }
