import 'dart:io';

import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_styles.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import '../utils/utilities.dart';
import 'buttons/app_button.dart';
import 'buttons/decorators/action_sheet_button_decorator.dart';
import 'snackbar/snackbar_style.dart';

@immutable
class ImageSourcePicker extends StatelessWidget {
  const ImageSourcePicker(
      {required this.imageSourceSelected,
      required this.isPickingImage,
      super.key});

  final Function(ImageSource source) imageSourceSelected;
  final bool isPickingImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(),
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: context.colorScheme.tertiary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  isPickingImage
                                      ? 'ImagePicker_message'.localized
                                      : 'VideoPicker_message'.localized,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.regularMedium(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(children: [
                          SizedBox(
                            height: 0.5,
                            child: Container(color: AppColors.primaryLight),
                          ),
                          AppButton(
                              title: 'ImagePicker_gallery'.localized,
                              textColor: context.colorScheme.onPrimary,
                              backgroundColor: context.colorScheme.tertiary,
                              elevation: 0,
                              radius: 0,
                              onClick: () {
                                _onPickFromGallery(context);
                              }),
                          SizedBox(
                            height: 0.5,
                            child: Container(color: AppColors.primaryLight),
                          ),
                          AppButton(
                              title: 'ImagePicker_camera'.localized,
                              textColor: context.colorScheme.onPrimary,
                              backgroundColor: context.colorScheme.tertiary,
                              elevation: 0,
                              radius: 0,
                              onClick: () {
                                _onPickFromCamera(context);
                              })
                        ])
                      ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AppButton(
                    title: 'Cancel'.localized,
                    height: 60,
                    button: ActionSheetButtonDecorator(),
                    textColor: context.colorScheme.primary,
                    backgroundColor: context.colorScheme.error,
                    onClick: () {
                      Navigator.pop(context);
                    })
              ])
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPickFromGallery(BuildContext context) async {
    var status = PermissionStatus.denied;
    var reStatus = PermissionStatus.denied;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.status;
        if (status.isDenied) {
          await Permission.storage.request();
        }
        reStatus = await Permission.storage.status;
      } else {
        status = await Permission.photos.status;
        if (status.isDenied) {
          await Permission.photos.request();
        }
        reStatus = await Permission.storage.status;
      }
    } else {
      status = await Permission.photos.status;
      if (status.isDenied) {
        await Permission.photos.request();
      }
      reStatus = await Permission.photos.status;
    }
    Navigator.pop(context);
    if (reStatus.isGranted || reStatus.isLimited) {
      imageSourceSelected.call(ImageSource.gallery);
    } else if (reStatus.isDenied ||
        reStatus.isRestricted ||
        reStatus.isPermanentlyDenied) {
      Utilities.showSnackBar(
          context, 'noGalleryAccess'.localized, SnackbarStyle.error);
    }
  }

  Future<void> _onPickFromCamera(BuildContext context) async {
    var status = PermissionStatus.denied;
    var reStatus = PermissionStatus.denied;
    if (Platform.isAndroid) {
      status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
      }
      reStatus = await Permission.camera.status;
    } else {
      status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
      }
      reStatus = await Permission.camera.status;
    }
    Navigator.pop(context);
    if (reStatus.isGranted) {
      imageSourceSelected.call(ImageSource.camera);
    } else if (reStatus.isDenied ||
        reStatus.isRestricted ||
        reStatus.isPermanentlyDenied) {
      Utilities.showSnackBar(
          context, 'noCameraAccess'.localized, SnackbarStyle.error);
    }
  }
}
