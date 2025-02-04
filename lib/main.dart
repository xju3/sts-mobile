
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jiwa/api/student_api.dart';
import 'package:logger/logger.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:jiwa/mixins/image_picker_mixin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '鸡娃',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '主页'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ImagePickerMixin {
  var logger = Logger();
  StudentApi studentApi = StudentApi();
  void handleImageSelection(BuildContext context, AssetEntity asset) {
    //logger.d(asset.size);
  }

  void _pickImages() async {
    List<AssetEntity>? assets =
        await openPicker(context, 9, handleImageSelection);
    if (null == assets || assets.isEmpty) return;
    final multipartFiles = <MultipartFile>[];
    for(AssetEntity image in assets) {
      var file = await image.file;
      if (null == file) continue;
      final fileBytes = await file.readAsBytes();
      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: file.path.split('/').last,
        contentType: MediaType('application', 'octet-stream'),
      );
      multipartFiles.add(multipartFile);
    }
    var ticket = await studentApi.uploadImages("studentId", multipartFiles);
    logger.d(ticket.ticketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        tooltip: '拍照',
        child: const Icon(Icons.add),
      ),
    );
  }
}
