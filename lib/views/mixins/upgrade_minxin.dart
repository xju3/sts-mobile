import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:duowoo/server/api/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:path_provider/path_provider.dart';

import '../../server/model/app_version.dart';

mixin UpgradeMixin<T extends StatefulWidget> on State<T> {
  final logger = Logger(printer: PrettyPrinter());
  final Random random = Random();
  // bool _showHint = false;

  Future<void> upgrade() async {
    if (!Platform.isAndroid) return;
    var url = 'http://app.aeons.me/app/version.json';
    await HttpClient()
        .getUrl(Uri.parse(url))
        .then((request) => request.close())
        .then((res) =>
            res.transform(const Utf8Decoder()).listen(phaseVersionText));
  }

  void phaseVersionText(String? version) async {
    if (null == version) return;
    var appVersion = AppVersion.fromJson(jsonDecode(version));
    if (AppConstants.kVersion == appVersion.version) {
      return;
    }

    var result = await confirm(context,
        title: const Text("版本更新"),
        content: Text(appVersion.changeLog!),
        textOK: const Text("立即更新"),
        textCancel: const Text('暂不更新'));
    if (result) {
      logger.d('更新.');
      var randomValue = random.nextInt(999);
      if (randomValue < 100) {
        randomValue += 100;
      }
      var url = "${AppConstants.kAndroidUpgradeUrl}/app/app-release.apk";
      downloadAndInstallApk(url);
    }
  }

  Future<void> downloadAndInstallApk(String apkUrl) async {
    // final Directory tempDir = await getTemporaryDirectory();
    // final String apkPath = '${tempDir.path}/app.apk';

    // final http.Response response = await http.get(Uri.parse(apkUrl));
    // final File file = File(apkPath);
    // await file.writeAsBytes(response.bodyBytes);

    // final AndroidIntent intent = AndroidIntent(
    //   action: 'android.intent.action.VIEW',
    //   data: Uri.file(apkPath),
    //   type: 'application/vnd.android.package-archive',
    // );
    // await intent.launch();
  }
}
