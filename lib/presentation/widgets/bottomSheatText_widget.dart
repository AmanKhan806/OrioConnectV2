import 'package:flutter/material.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';
import 'package:orioconnect/Utils/TextWidget/App_text.dart';

Widget buildDetailRow({
  required BuildContext context,
  required IconData icon,
  required String label,
  required String value,
  Color? valueColor,
  bool isBold = false,
  bool isMultiline = false,
}) {
  return Row(
    crossAxisAlignment: isMultiline
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: context.responsiveWidth(0.045),
        color: ColorResources.appMainColor,
      ),
      SizedBox(width: context.responsiveWidth(0.03)),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextStyle.custom(
              context: context,
              text: label,
              fontSize: context.responsiveWidth(0.03),
              fontWeight: FontWeight.w400,
              color: ColorResources.blackColor.withAlpha(153),
            ),
            SizedBox(height: context.responsiveHeight(0.001)),
            AppTextStyle.custom(
              context: context,
              text: value,
              fontSize: context.responsiveWidth(0.037),
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
              color: valueColor ?? ColorResources.blackColor,
              maxLines: isMultiline ? null : 1,
              overflow: isMultiline ? null : TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildBottomSheetDivider(BuildContext context) {
  return Divider(color: ColorResources.blackColor.withAlpha(26), height: 1);
}


Widget buildStatusChip<T>({
  required BuildContext context,
  required String label,
  required T? value,
  required T? selectedValue,
  required Function(T?) onSelected,
  Color? selectedColor,
  Color? backgroundColor,
  Color? selectedTextColor,
  Color? unselectedTextColor,
}) {
  final isSelected = selectedValue == value;
  return FilterChip(
    label: AppTextStyle.custom(
      context: context,
      text: label,
      fontSize: context.responsiveWidth(0.030),
      fontWeight: FontWeight.w400,
      color: isSelected
          ? (selectedTextColor ?? ColorResources.whiteColor)
          : (unselectedTextColor ?? ColorResources.blackColor),
    ),
    selected: isSelected,
    onSelected: (selected) {
      onSelected(selected ? value : null);
    },
    backgroundColor: backgroundColor ?? ColorResources.textfeildColor,
    selectedColor: selectedColor ?? ColorResources.appMainColor,
    checkmarkColor: ColorResources.whiteColor,
  );
}