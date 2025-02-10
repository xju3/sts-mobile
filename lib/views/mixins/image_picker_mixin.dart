import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:duowoo/server/api/minio_api.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

mixin ImagePickerMixin<T extends StatefulWidget> {
  final log = Logger(printer: PrettyPrinter());
  final List<AssetEntity> assets = List.of({});
  final AssetPickerTextDelegate textDelegate = const AssetPickerTextDelegate();
  final uuid = const Uuid();
  final dio = Dio();
  final minioApi = MinioApi();
  final String assetsLoading = 'assets/images/spin-1s-200px.gif';

  Future<AssetEntity?> _pickFromCamera(BuildContext ctx) {
    return CameraPicker.pickFromCamera(
      ctx,
      pickerConfig: const CameraPickerConfig(
          enableRecording: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
          resolutionPreset: ResolutionPreset.medium),
    );
  }

  bool _isImage(String url) {
    var ext = url.split('.').last;
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp']
        .contains(ext.toLowerCase())) return true;
    return false;
  }

  String _getImageUrl(String url) {
    if (!_isImage(url)) {
      return url.toLowerCase().replaceAll(".mp4", '_video.png');
    }
    return url;
  }

  String _getContextType(String ext) {
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp']
        .contains(ext.toLowerCase())) {
      return "image/$ext";
    }
    return "video/$ext";
  }

  Future<List<AssetEntity>?> mxOpenPicker(
    BuildContext context,
    int maxAssetsCount,
    Function(BuildContext, AssetEntity) handleResult,
  ) async {
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

  Future<void> mxMinioUpload(List<AssetEntity> elements, String resourceId,
      Function(int, bool) onSuccess) async {
    // var total = elements.length;

    var index = 0;
    for (var element in elements) {
      index++;
      var file = await element.file;
      if (null == file) return;
      var ext = file.path.split(".").last;
      var fileName = '$index.$ext';
      if (!_isImage(fileName)) {
        continue;
      }
      var singleValue =
          await minioApi.getPreassignedPutKey('$resourceId/$fileName');
      var url = singleValue.content;
      if (url == null) {
        onSuccess(index, false);
        return;
      }

      var bytes = file.openRead();
      var length = await file.length();
      await dio.put(url,
          data: bytes,
          options: Options(
            headers: {
              'Content-Type': _getContextType(ext),
              'Accept': "*/*",
              'Content-Length': length.toString(),
              'Connection': 'keep-alive',
            },
          ));
      onSuccess(index, true);
    }
  }
}
