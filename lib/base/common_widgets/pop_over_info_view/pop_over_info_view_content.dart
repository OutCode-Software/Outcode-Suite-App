import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../base/common_widgets/image_widgets/app_image_view.dart';
import '../../utils/app_styles.dart';
import '../../utils/colors.dart';
import '../buttons/app_button.dart';
import '../buttons/decorators/primary_button_decorator.dart';
import 'open_view_type.dart';
import 'pop_over_content_model_domain.dart';

class PopOverInfoViewContent extends StatefulWidget {
  const PopOverInfoViewContent(
      {required this.model, required this.onOpenViewType, super.key});
  final PopOverContentModelDomain model;
  final Function(PopUpOpenViewType)? onOpenViewType;

  @override
  State<PopOverInfoViewContent> createState() => _PopOverInfoViewContentState();
}

class _PopOverInfoViewContentState extends State<PopOverInfoViewContent> {
  late FlickManager _flickManager;
  bool _isVideoPlayerInitialized = false;
  bool _isThumbnailShowing = true;
  @override
  void initState() {
    super.initState();
    _configurePlayer();
  }

  Future<void> _configurePlayer() async {
    if (widget.model.videoUrl != null) {
      final file =
          await DefaultCacheManager().getFileFromCache(widget.model.videoUrl!);
      if (file == null) {
        await DefaultCacheManager()
            .downloadFile(widget.model.videoUrl!)
            .then((value) {})
            .catchError(print);
        _flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.network(
              widget.model.videoUrl!,
            ),
            autoPlay: false);
        _isVideoPlayerInitialized = true;
      } else {
        _flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.file(file.file),
            autoPlay: false);
        _isVideoPlayerInitialized = true;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _flickManager.flickControlManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.bottomSheetTheme.modalBarrierColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.colorScheme.secondary),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(children: [
                        Visibility(
                          visible: widget.model.avatarUrl != null,
                          child: AppImageView(
                            width: 72,
                            height: 72,
                            cornerRadius: 36,
                            avatarUrl: widget.model.avatarUrl,
                          ),
                        ),
                        Visibility(
                          visible: widget.model.title.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  widget.model.title,
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.headlineLarge,
                                ))
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget.model.text.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 15, right: 15),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  widget.model.text,
                                  style: AppStyles.regularSmall(
                                      color: AppColors.black),
                                  textAlign: TextAlign.center,
                                ))
                              ],
                            ),
                          ),
                        ),
                        _isVideoPlayerInitialized
                            ? Visibility(
                                visible: widget.model.videoUrl != null,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 21, bottom: 10),
                                    child: Stack(
                                      children: [
                                        FlickVideoPlayer(
                                            flickVideoWithControls:
                                                FlickVideoWithControls(
                                              videoFit: BoxFit.fitWidth,
                                              controls: FlickPortraitControls(
                                                progressBarSettings:
                                                    FlickProgressBarSettings(
                                                        playedColor:
                                                            Colors.green),
                                              ),
                                            ),
                                            flickManager: _flickManager),
                                        _thumbnailView()
                                      ],
                                    )))
                            : const SizedBox.shrink(),
                        Visibility(
                          visible: widget.model.buttonTitle.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 21, left: 15, right: 15),
                            child: AppButton(
                                onClick: () {
                                  _flickManager.flickControlManager?.pause();
                                  _onButtonClick(context);
                                },
                                title: widget.model.buttonTitle,
                                button: PrimaryButtonDecorator()),
                          ),
                        )
                      ]),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close_outlined,
                          ),
                          onPressed: () {
                            _flickManager.flickControlManager?.pause();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonClick(BuildContext context) {
    Navigator.pop(context);
    widget.onOpenViewType?.call(widget.model.buttonType);
  }

  Widget _thumbnailView() {
    return Visibility(
      visible: _isThumbnailShowing,
      child: Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Stack(
          children: [
            AppImageView(
              avatarUrl: widget.model.thumbnailUrl,
              width: double.maxFinite,
              height: double.maxFinite,
              cornerRadius: 0,
            ),
            Container(
              color: AppColors.black.withOpacity(0.5),
            ),
            Center(
              child: IconButton(
                  onPressed: () {
                    _isThumbnailShowing = false;
                    _flickManager.flickControlManager?.play();
                    setState(() {});
                  },
                  iconSize: 150,
                  color: AppColors.white,
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
