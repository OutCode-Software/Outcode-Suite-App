import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../base/common_widgets/navbar/nav_bar.dart';
import '../../base/utils/colors.dart';

class FullScreenPhotoView extends StatefulWidget {
  const FullScreenPhotoView({required this.photoUrls, super.key});
  final List<String?> photoUrls;

  @override
  State<FullScreenPhotoView> createState() => _FullScreenPhotoViewState();

  static Route<void> route(List<String?> photoUrls) {
    return MaterialPageRoute<void>(
        builder: (_) => FullScreenPhotoView(
              photoUrls: photoUrls,
            ));
  }
}

class _FullScreenPhotoViewState extends State<FullScreenPhotoView> {
  List<String> photoUrls = [];

  @override
  void initState() {
    photoUrls = widget.photoUrls
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
    super.initState();
  }

  String? getCacheKey(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }
    return '${uri.scheme}://${uri.host}/${uri.path}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        children: [
          _navBar(),
          Expanded(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: photoUrls[index].hashCode),
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                  imageProvider: CachedNetworkImageProvider(photoUrls[index],
                      cacheKey: getCacheKey(photoUrls[index])),
                );
              },
              itemCount: photoUrls.length,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navBar() {
    return NavBar(
      navStyle: NavStyle.singleLined,
      backgroundColor: AppColors.transparent,
      showsLeftButton: true,
      onBackButtonClicked: () {
        Navigator.pop(context);
      },
      leftButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {},
      ),
    );
  }
}
