import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../Colors/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isPasswordField;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextInputType keyboardType;
  final int maxLines;
  final bool expands;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;
  final bool showBorder;
  final double borderRadius;
  final Color? customFocusedBorderColor;
  final Color? customEnabledBorderColor;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.obscureText = false,
    this.isPasswordField = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.showBorder = true,
    this.borderRadius = 14.0,
    this.customFocusedBorderColor,
    this.customEnabledBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      expands: expands,
      readOnly: readOnly,
      onTap: onTap,
      style: _getTextStyle(),
      cursorColor: ColorResources.appMainColor, // Cursor color fix
      decoration: _buildDecoration(),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      suffixIcon: _buildSuffixIcon(),

      // Label colors fix
      labelStyle: TextStyle(
        fontSize: 13,
        color: ColorResources.blackColor.withOpacity(0.6),
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 14,
        color: ColorResources.appMainColor, // Floating label color
        fontWeight: FontWeight.w500,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorResources.textfeildColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorResources.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorResources.appMainColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorResources.gradientRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: ColorResources.gradientRed, width: 2.0),
      ),
      fillColor: ColorResources.greyColor,
      filled: true,

      // Error style
      errorStyle: TextStyle(color: ColorResources.gradientRed, fontSize: 12),
    );
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: ColorResources.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  Widget? _buildSuffixIcon() {
    if (isPasswordField) {
      return IconButton(
        onPressed: onSuffixIconPressed,
        icon: Icon(
          obscureText ? Iconsax.eye_slash : Iconsax.eye,
          color: ColorResources.blackColor.withOpacity(0.6),
        ),
      );
    } else if (suffixIcon != null) {
      return IconButton(
        onPressed: onSuffixIconPressed,
        icon: Icon(
          suffixIcon,
          color: ColorResources.blackColor.withOpacity(0.6),
        ),
      );
    }
    return null;
  }
}

class CustomDropdownWidget {
  static Widget customDropdown({
    required BuildContext context,
    required String labelText,
    required String? selectedValue,
    required List<String> items,
    required Function(String?) onChanged,
    String? fieldName = 'Field',
    String? hintText,
    bool showBorder = true,
    double borderRadius = 14.0,
    Color? customFocusedBorderColor,
    Color? customEnabledBorderColor,
    bool isSearchable = true,
  }) {
    return _CustomDropdownFormField(
      context: context,
      labelText: labelText,
      selectedValue: selectedValue,
      items: items,
      onChanged: onChanged,
      fieldName: fieldName,
      hintText: hintText,
      showBorder: showBorder,
      borderRadius: borderRadius,
      customFocusedBorderColor: customFocusedBorderColor,
      customEnabledBorderColor: customEnabledBorderColor,
      isSearchable: isSearchable,
    );
  }
}

class _CustomDropdownFormField extends StatelessWidget {
  final BuildContext context;
  final String labelText;
  final String? selectedValue;
  final List<String> items;
  final Function(String?) onChanged;
  final String? fieldName;
  final String? hintText;
  final bool showBorder;
  final double borderRadius;
  final Color? customFocusedBorderColor;
  final Color? customEnabledBorderColor;
  final bool isSearchable;

  const _CustomDropdownFormField({
    Key? key,
    required this.context,
    required this.labelText,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.fieldName,
    this.hintText,
    this.showBorder = true,
    this.borderRadius = 14.0,
    this.customFocusedBorderColor,
    this.customEnabledBorderColor,
    this.isSearchable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasValue = selectedValue != null && selectedValue!.isNotEmpty;
    return GestureDetector(
      onTap: () => _showDropdownBottomSheet(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: ColorResources.greyColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40, // Fixed height for consistent alignment
                  alignment: hasValue
                      ? Alignment.centerLeft
                      : Alignment.centerLeft,
                  child: Text(
                    hasValue ? (selectedValue ?? '') : (hintText ?? labelText),
                    style: TextStyle(
                      fontSize: 13,
                      color: hasValue
                          ? ColorResources.blackColor
                          : ColorResources.blackColor.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: ColorResources.blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DropdownBottomSheet(
        title: labelText,
        items: items,
        selectedValue: selectedValue,
        onChanged: onChanged,
        isSearchable: isSearchable,
      ),
    );
  }
}

class _DropdownBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final bool isSearchable;

  const _DropdownBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.isSearchable,
  }) : super(key: key);

  @override
  State<_DropdownBottomSheet> createState() => _DropdownBottomSheetState();
}

class _DropdownBottomSheetState extends State<_DropdownBottomSheet> {
  late List<String> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Select ${widget.title}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.black),
                ),
              ],
            ),
          ),

          // Search Field
          if (widget.isSearchable) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextFormField(
                controller: searchController,
                labelText: 'Search ${widget.title}',
                suffixIcon: Icons.search,
                showBorder: true,
              ),
            ),
          ],

          // Items List
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'No items found',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isSelected = item == widget.selectedValue;

                      return ListTile(
                        title: Text(
                          item,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check, color: Colors.black)
                            : null,
                        onTap: () {
                          widget.onChanged(item);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CustomTimePickerField extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final VoidCallback onTap;

  const CustomTimePickerField({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTap,
  });

  String _formatTime(TimeOfDay? time) {
    if (time == null) return "--:--";
    
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: mq.size.width * 0.04,
          vertical: mq.size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: ColorResources.blackColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Colors.black38),
            SizedBox(width: mq.size.width * 0.04),
            Expanded(
              child: Text(
                "$label: ${_formatTime(selectedTime)}",
                style: TextStyle(
                  color: selectedTime == null ? Colors.black38 : Colors.black87,
                  fontSize: mq.size.width * 0.035,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
