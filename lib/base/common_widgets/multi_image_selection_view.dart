import 'dart:io';

import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/core/domain/domain_models/image_selection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../utils/utilities.dart';
import 'buttons/image_button.dart';
import 'image_source_picker.dart';
import 'snackbar/snackbar_style.dart';

class MultiImageSelectionView extends StatefulWidget {
  const MultiImageSelectionView(
      {required this.initialImages, this.maxCount, super.key});
  final List<ImageSelectionModel> initialImages;
  final int? maxCount;

  @override
  State<MultiImageSelectionView> createState() =>
      _MultiImageSelectionViewState();
}

class _MultiImageSelectionViewState extends State<MultiImageSelectionView> {
  var _images = <ImageSelectionModel>[];
  int? _maxCount;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setUpImages();
  }

  void _setUpImages() {
    _images = List.from(widget.initialImages);
    _maxCount = widget.maxCount;
    _configureImageSet();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _images.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _itemView(_images[index], index);
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(() {})
      ..dispose();
  }

  Widget _itemView(ImageSelectionModel file, int index) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 5),
        child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colorScheme.onPrimary,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: context.colorScheme.tertiary)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: file.isDummy
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: context.colorScheme.onPrimary,
                        ),
                        onPressed: _pickImageSource,
                      ),
                    )
                  : Image.file(
                      File(file.file!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            )),
      ),
      Visibility(
        visible: !file.isDummy,
        child: Positioned(
            right: 0,
            top: 0,
            child: ImageButton(
              height: 30,
              iconScale: 0.5,
              icon: FontAwesomeIcons.xmark,
              backgroundColor: context.colorScheme.onPrimary,
              iconColor: context.colorScheme.onError,
              isCircular: true,
              onClick: () {
                _images.removeAt(index);
                _configureImageSet();
              },
            )),
      )
    ]);
  }

  void _configureImageSet() {
    final index = _images.indexWhere((element) => element.isDummy);
    if (index != -1) {
      _images.removeAt(index);
    }

    if (_maxCount != null) {
      if (_images.length < _maxCount!) {
        _images.add(ImageSelectionModel.getDummyModel());
      }
    } else {
      _images.add(ImageSelectionModel.getDummyModel());
    }
    setState(() {});
  }

  Future<void> _pickImageSource() async {
    Utilities.showBottomSheet(
        widget: ImageSourcePicker(
          imageSourceSelected: (imageSourceSelected) {
            _pickImage(imageSource: imageSourceSelected);
          },
          isPickingImage: true,
        ),
        context: context);
  }

  Future<void> _pickImage({required ImageSource imageSource}) async {
    final imagePicker = ImagePicker();
    final imageCropper = ImageCropper();
    try {
      final selectedImage =
          await imagePicker.pickImage(source: imageSource, imageQuality: 100);
      if (selectedImage != null) {
        final croppedFile = await imageCropper.cropImage(
          sourcePath: selectedImage.path,
          compressQuality: 80,
          aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
          uiSettings: Utilities.imageCropperSettings(context: context),
        );
        if (croppedFile != null) {
          _images.add(ImageSelectionModel(
              id: const Uuid().v4(), file: XFile(croppedFile.path)));
          _configureImageSet();
          Future.delayed(const Duration(seconds: 1), () async {
            await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 500),
            );
          });
        }
      }
    } on PlatformException catch (e) {
      Utilities.showSnackBar(
          context, e.message ?? 'Error', SnackbarStyle.error);
    }
  }
}
