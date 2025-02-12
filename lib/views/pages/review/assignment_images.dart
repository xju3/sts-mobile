import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:duowoo/views/pages/common/base.dart';

class AssignmentImagesPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const AssignmentImagesPage(
      {Key? key, required this.imageUrls, this.initialIndex = 0})
      : super(key: key);

  @override
  State<AssignmentImagesPage> createState() => _AssignmentImagesPageState();
}

class _AssignmentImagesPageState extends BasePage<AssignmentImagesPage> {
  late int currentIndex = widget.initialIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${currentIndex + 1}/${widget.imageUrls.length}"),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider:
                  CachedNetworkImageProvider(widget.imageUrls[index]),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(tag: index),
            );
          },
          itemCount: widget.imageUrls.length,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          pageController: pageController,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}
