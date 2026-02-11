import 'dart:developer';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orioconnect/Utils/Colors/colors.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';

extension AppWidgetExtension on Widget {
  Widget noKeyboard() => GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
    child: this,
  );
}

class CustomDateRangePicker extends StatefulWidget {
  final Function(DateTime?, DateTime?) onDateRangeSelected;
  final bool allowFutureDates;
  final bool allowPastDates;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final String? title;

  const CustomDateRangePicker({
    super.key,
    required this.onDateRangeSelected,
    this.allowFutureDates = false,
    this.allowPastDates = true,
    this.firstDate,
    this.lastDate,
    this.initialStartDate,
    this.initialEndDate,
    this.title,
  });

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  List<DateTime?> selectedDateRange = [];

  @override
  void initState() {
    super.initState();
    // FIXED: Properly initialize with both dates (no filtering)
    if (widget.initialStartDate != null && widget.initialEndDate != null) {
      selectedDateRange = [widget.initialStartDate, widget.initialEndDate];
      log(
        "Date picker initialized with: ${DateFormat('yyyy-MM-dd').format(widget.initialStartDate!)} to ${DateFormat('yyyy-MM-dd').format(widget.initialEndDate!)}",
      );
    } else {
      selectedDateRange = [];
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Calculate date constraints
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime firstDate =
        widget.firstDate ??
        (widget.allowPastDates ? DateTime(now.year - 1) : today);
    DateTime lastDate =
        widget.lastDate ??
        (widget.allowFutureDates ? DateTime(now.year + 1) : today);

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.85),
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          top: screenHeight * 0.02,
          bottom:
              MediaQuery.of(context).viewInsets.bottom + screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.title ?? 'Select Date Range',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorResources.appMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    onPressed: () {
                      // Validate that we have both start and end dates
                      if (selectedDateRange.length >= 2 &&
                          selectedDateRange[0] != null &&
                          selectedDateRange[1] != null) {
                        widget.onDateRangeSelected(
                          selectedDateRange[0],
                          selectedDateRange[1],
                        );
                        Navigator.pop(context);
                      } else {
                        customSnackBar(
                          "Invalid Date Range",
                          "Please select both start and end dates",
                          snackBarType: SnackBarType.error,
                        );
                      }
                    },
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),

            Expanded(
              child: SingleChildScrollView(
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.range,
                    selectedDayHighlightColor: ColorResources.appMainColor,
                    selectedRangeHighlightColor: ColorResources.appMainColor
                        .withOpacity(0.3),
                    selectedDayTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    todayTextStyle: const TextStyle(
                      color: ColorResources.appMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    controlsTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    dayTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    disabledDayTextStyle: const TextStyle(color: Colors.grey),
                    weekdayLabelTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    firstDate: firstDate,
                    lastDate: lastDate,
                    currentDate: now,
                    disableModePicker: true,
                    lastMonthIcon: const Icon(Icons.chevron_left),
                    nextMonthIcon: const Icon(Icons.chevron_right),
                    centerAlignModePicker: true,
                    rangeBidirectional: true,
                  ),
                  value: selectedDateRange,
                  onValueChanged: (List<DateTime?> values) {
                    setState(() {
                      // Handle date selection properly
                      selectedDateRange = values;
                      log("Date range updated: $values");
                    });
                  },
                ),
              ),
            ),

            // Selected date range display
            if (selectedDateRange.isNotEmpty && selectedDateRange[0] != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Text(
                  selectedDateRange.length >= 2 && selectedDateRange[1] != null
                      ? "Selected: ${formatDate(selectedDateRange[0]!)} - ${formatDate(selectedDateRange[1]!)}"
                      : "Start: ${formatDate(selectedDateRange[0]!)} (Select end date)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        selectedDateRange.length >= 2 &&
                            selectedDateRange[1] != null
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),
              ),
            SizedBox(height: screenHeight * 0.01),
          ],
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime?)? onDateSelected;
  final Function(DateTime?, DateTime?)? onDateRangeSelected;

  final bool isRangePicker;
  final bool allowFutureDates;
  final bool allowPastDates;
  final DateTime? firstDate;
  final DateTime? lastDate;

  final DateTime? initialDate;

  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  final String? title;

  const CustomDatePicker({
    super.key,
    this.onDateSelected,
    this.onDateRangeSelected,
    this.isRangePicker = false,
    this.allowFutureDates = false,
    this.allowPastDates = true,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.initialStartDate,
    this.initialEndDate,
    this.title,
  }) : assert(
         (isRangePicker && onDateRangeSelected != null) ||
             (!isRangePicker && onDateSelected != null),
         'Must provide onDateRangeSelected for range picker or onDateSelected for single date picker',
       );

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  List<DateTime?> selectedDates = [];

  @override
  void initState() {
    super.initState();
    if (widget.isRangePicker) {
      selectedDates = [
        widget.initialStartDate,
        widget.initialEndDate,
      ].where((date) => date != null).toList();
    } else {
      if (widget.initialDate != null) {
        selectedDates = [widget.initialDate];
      }
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Calculate date constraints
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime firstDate =
        widget.firstDate ??
        (widget.allowPastDates ? DateTime(now.year - 1) : today);
    DateTime lastDate =
        widget.lastDate ??
        (widget.allowFutureDates ? DateTime(now.year + 1) : today);

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.85),
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          top: screenHeight * 0.02,
          bottom:
              MediaQuery.of(context).viewInsets.bottom + screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.title ??
                  (widget.isRangePicker ? 'Select Date Range' : 'Select Date'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorResources.appMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    onPressed: () {
                      if (widget.isRangePicker) {
                        // Date range validation
                        final start = selectedDates.isNotEmpty
                            ? selectedDates[0]
                            : null;
                        final end = selectedDates.length > 1
                            ? selectedDates[1]
                            : null;

                        if (start != null && end != null) {
                          widget.onDateRangeSelected!(start, end);
                          Navigator.pop(context);
                        } else {
                          customSnackBar(
                            "Invalid Date Range",
                            "Please select a valid date range",
                            snackBarType: SnackBarType.error,
                          );
                        }
                      } else {
                        // Single date validation
                        if (selectedDates.isNotEmpty &&
                            selectedDates[0] != null) {
                          widget.onDateSelected!(selectedDates[0]);
                          Navigator.pop(context);
                        } else {
                          customSnackBar(
                            "Invalid Date",
                            "Please select a date",
                            snackBarType: SnackBarType.error,
                          );
                        }
                      }
                    },
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: widget.isRangePicker
                      ? CalendarDatePicker2Type.range
                      : CalendarDatePicker2Type.single,
                  selectedDayHighlightColor: ColorResources.appMainColor,
                  selectedRangeHighlightColor: ColorResources.appMainColor
                      .withOpacity(0.3),
                  selectedDayTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  todayTextStyle: const TextStyle(
                    color: ColorResources.appMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  controlsTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  dayTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  disabledDayTextStyle: const TextStyle(color: Colors.grey),
                  weekdayLabelTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  firstDate: firstDate,
                  lastDate: lastDate,
                  currentDate: now,
                  disableModePicker: true,
                  lastMonthIcon: const Icon(Icons.chevron_left),
                  nextMonthIcon: const Icon(Icons.chevron_right),
                  centerAlignModePicker: true,
                ),
                value: selectedDates,
                onValueChanged: (List<DateTime?> values) {
                  setState(() {
                    if (widget.isRangePicker) {
                      // Always maintain exactly 2 items in the list for range
                      if (values.isEmpty) {
                        selectedDates = [null, null];
                      } else if (values.length == 1) {
                        selectedDates = [values[0], null];
                      } else {
                        // Take the first two dates if more than 2 are selected
                        selectedDates = [values[0], values[1]];
                      }
                    } else {
                      // Single date selection
                      selectedDates = values.isNotEmpty ? [values[0]] : [];
                    }
                  });
                },
              ),
            ),

            // Selected date display
            if (widget.isRangePicker)
              // Date range display
              if (selectedDates.length >= 2 &&
                  selectedDates[0] != null &&
                  selectedDates[1] != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Text(
                    "Selected: ${formatDate(selectedDates[0]!)} - ${formatDate(selectedDates[1]!)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                )
              else
                const SizedBox.shrink()
            else
            // Single date display
            if (selectedDates.isNotEmpty && selectedDates[0] != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Text(
                  "Selected: ${formatDate(selectedDates[0]!)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
