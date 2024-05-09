import 'dart:math';

import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:logging/logging.dart';

import '../common_widgets/snackbar/snackbar_content.dart';
import '../common_widgets/snackbar/snackbar_style.dart';
import 'colors.dart';

// ignore: avoid_classes_with_only_static_members
class Utilities {
  static void printObj(Object message) {
    if (kDebugMode) {
      Logger.root.info(message);
      print(message);
    }
  }

  static bool isAndroid() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void showSnackBar(
      BuildContext context, String message, SnackbarStyle style) {
    if (message.isEmpty) {
      return;
    }
    _showOverlay(context, text: message, style: style);
  }

  static Future<void> _showOverlay(BuildContext context,
      {required String text, required SnackbarStyle style}) async {
    final overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 10,
        right: 10,
        bottom: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: SnackBarContent(message: text, style: style),
          ),
        ),
      );
    });
    // inserting overlay entry
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2))
        // removing overlay entry after stipulated time.
        .whenComplete(() => overlayEntry.remove());
  }

  static void showBottomSheet({
    required Widget widget,
    required BuildContext context,
    Color? backgroundColor,
    bool isDismissable = true,
  }) {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        isDismissible: isDismissable,
        barrierColor: context.theme.bottomSheetTheme.modalBarrierColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
        context: context,
        isScrollControlled: true,
        builder: (context) => widget);
  }

  static String generateRadomCode(int digitCount) {
    final random = Random();
    final code = random.nextInt(900000) + 100000;
    return code.toString();
  }

  static int generateRandomInt(int max) {
    final random = Random();
    return random.nextInt(max);
  }

  static bool hasAppUpdate(
      {required String existingVersion, required String remoteVersion}) {
    final existingVersionChunks =
        existingVersion.split('.').map(int.parse).toList();
    final remoteVersionChunks =
        remoteVersion.split('.').map(int.parse).toList();
    if ((existingVersionChunks.length != 3) ||
        (remoteVersionChunks.length != 3)) {
      return false;
    }
    if (remoteVersionChunks[0] > existingVersionChunks[0]) {
      return true;
    } else if (remoteVersionChunks[0] == existingVersionChunks[0]) {
      if (remoteVersionChunks[1] > existingVersionChunks[1]) {
        return true;
      } else if (remoteVersionChunks[1] == existingVersionChunks[1]) {
        if (remoteVersionChunks[2] > existingVersionChunks[2]) {
          return true;
        }
      }
    }
    return false;
  }

  static List<PlatformUiSettings> imageCropperSettings(
      {required BuildContext context}) {
    return [
      AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          statusBarColor: context.colorScheme.secondary,
          toolbarColor: context.colorScheme.secondary,
          toolbarWidgetColor: context.colorScheme.onPrimary,
          activeControlsWidgetColor: context.colorScheme.onPrimary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      IOSUiSettings(
        title: 'Crop Image',
        aspectRatioPickerButtonHidden: true,
        aspectRatioLockEnabled: true,
      )
    ];
  }
}
