import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';


mixin ImagePickerMixin<T extends StatefulWidget> {

  final log = Logger(printer: PrettyPrinter());
  final List<AssetEntity> assets = List.of({});
  final AssetPickerTextDelegate textDelegate = const AssetPickerTextDelegate();
  final uuid = const Uuid();
  final dio = Dio();
  final String assetsLoading = 'assets/images/spin-1s-200px.gif';

  Future<AssetEntity?> _pickFromCamera(BuildContext ctx) {
    return CameraPicker.pickFromCamera(
      ctx,
      pickerConfig: const CameraPickerConfig(enableRecording: false),
    );
  }

  bool isImage(String url) {
    var ext = url.split('.').last;
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext.toLowerCase())) return true;
    return false;
  }

  String getImageUrl(String url) {
    if (!isImage(url)) {
      return url.toLowerCase().replaceAll(".mp4", '_video.png');
    }
    return url;
  }

  void initFadeInImages( List<String> resources, List<Widget> images, String bucket, String id, List<ImageProvider> imageProviders) {
    imageProviders.clear();
    for (var resource in resources) {
      var url = "";
      imageProviders.add(CachedNetworkImageProvider(url));
      url = getImageUrl(url);
      images.add(Container(
        width: 130,
        height: 130,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15) // Adjust the radius as needed
        ),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
          height: 25.0,
          // placeholder: (context, url) => const CircularProgressIndicator(
          //   strokeWidth: 1,
          //   strokeCap: StrokeCap.round,
          // ),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              LinearProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.blue,
              ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ));
    }
  }

  String getContextType(String ext) {
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext.toLowerCase())) return "image/$ext";
    return "video/$ext";
  }

  Future<List<AssetEntity>?> openPicker(BuildContext context, int maxAssetsCount,
      Function(BuildContext, AssetEntity) handleResult, ) async {
    return AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: maxAssetsCount,
        selectedAssets: assets,
        specialItemPosition: SpecialItemPosition.prepend,
        specialItemBuilder: (
            BuildContext context,
            AssetPathEntity? path,
            int length,
            ) {
          if (path?.isAll != true) {
            return null;
          }
          return Semantics(
            label: textDelegate.sActionUseCameraHint,
            button: true,
            onTapHint: textDelegate.sActionUseCameraHint,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                Feedback.forTap(context);
                final AssetEntity? result = await _pickFromCamera(context);
                if (result != null) {
                  handleResult(context, result);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(28.0),
                color: Theme.of(context).dividerColor,
                child: const FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(Icons.camera_enhance),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
