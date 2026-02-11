import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum SnackBarType { success, error, info, warning }

// Class to hold SnackBar data
class SnackBarData {
  final String title;
  final String message;
  final SnackBarType snackBarType;
  final int durationSeconds;
  final VoidCallback? actionCallback;
  final String? actionLabel;

  SnackBarData({
    required this.title,
    required this.message,
    this.snackBarType = SnackBarType.success,
    this.durationSeconds = 3,
    this.actionCallback,
    this.actionLabel,
  });
}

class SnackBarQueue {
  static final Queue<SnackBarData> _queue = Queue<SnackBarData>();
  static bool _isShowing = false;

  static void addToQueue(
    String title,
    String message, {
    SnackBarType snackBarType = SnackBarType.success,
    int durationSeconds = 3,
    VoidCallback? actionCallback,
    String? actionLabel,
    SnackPosition snackPosition = SnackPosition.TOP,
  }) {
    _queue.add(
      SnackBarData(
        title: title,
        message: message,
        snackBarType: snackBarType,
        durationSeconds: durationSeconds,
        actionCallback: actionCallback,
        actionLabel: actionLabel,
      ),
    );
    _showNextSnackBar(snackPosition);
  }

  static void _showNextSnackBar(SnackPosition snackPosition) {
    if (_isShowing || _queue.isEmpty) return;

    _isShowing = true;
    final snackBarData = _queue.removeFirst();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      customSnackBar(
        snackBarData.title,
        snackBarData.message,
        snackBarType: snackBarData.snackBarType,
        durationSeconds: snackBarData.durationSeconds,
        actionCallback: snackBarData.actionCallback,
        actionLabel: snackBarData.actionLabel,
        snackPosition: snackPosition,
        onDismissed: () {
          _isShowing = false;
          _showNextSnackBar(snackPosition);
        },
      );
    });
  }

  static void clearQueue() {
    _queue.clear();
    _isShowing = false;
  }
}

// Simple and Compact Custom SnackBar
void customSnackBar(
  String title,
  String message, {
  SnackBarType snackBarType = SnackBarType.success,
  int durationSeconds = 3,
  VoidCallback? onDismissed,
  VoidCallback? actionCallback,
  String? actionLabel,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
}) {
  if (Get.context == null) return;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    HapticFeedback.lightImpact();

    final mediaQuery = MediaQuery.of(Get.context!);
    final screenWidth = mediaQuery.size.width;

    Get.snackbar(
      '',
      '',
      titleText: _CompactSnackBarContent(
        message: message,
        snackBarType: snackBarType,
        screenWidth: screenWidth,
      ),
      messageText: const SizedBox.shrink(),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 8.0,
      ),
      duration: Duration(seconds: durationSeconds),
      backgroundColor: Colors.transparent,
      snackPosition: snackPosition,
      borderRadius: 0,  // ✅ No rounded corners
      animationDuration: const Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      overlayBlur: 0,
      boxShadows: [],
      onTap: (GetSnackBar snackBar) {
        Get.closeCurrentSnackbar();
        onDismissed?.call();
      },
    );
  });
}

// Compact SnackBar Content Widget
class _CompactSnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarType snackBarType;
  final double screenWidth;

  const _CompactSnackBarContent({
    required this.message,
    required this.snackBarType,
    required this.screenWidth,
  });

  IconData _getIconData() {
    switch (snackBarType) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  Color _getIconColor() {
    switch (snackBarType) {
      case SnackBarType.success:
        return Colors.green[700]!;
      case SnackBarType.error:
        return Colors.red[700]!;
      case SnackBarType.info:
        return Colors.blue[700]!;
      case SnackBarType.warning:
        return Colors.orange[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],  // ✅ Simple dark grey background
        border: Border.all(
          color: Colors.grey[700]!,  // ✅ Subtle border
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getIconData(),
            color: _getIconColor(),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Convenience methods for banking app
class BankingSnackBar {
  static void showTransactionSuccess(String message, {String? transactionId}) {
    customSnackBar(
      'Success',
      message,
      snackBarType: SnackBarType.success,
      durationSeconds: 3,
    );
  }

  static void showTransactionFailed(String message) {
    customSnackBar(
      'Failed',
      message,
      snackBarType: SnackBarType.error,
      durationSeconds: 4,
    );
  }

  static void showSecurityAlert(String message) {
    customSnackBar(
      'Alert',
      message,
      snackBarType: SnackBarType.warning,
      durationSeconds: 4,
    );
  }

  static void showAccountUpdate(String message) {
    customSnackBar(
      'Info',
      message,
      snackBarType: SnackBarType.info,
      durationSeconds: 3,
    );
  }
}
