import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:jiwa/mixins/image_picker_mixin.dart';
import 'package:jiwa/mixins/home_mixin.dart';
import 'package:jiwa/server/api/review_api.dart';
import 'package:jiwa/widges/draggable_button.dart';

import '../server/model/review_ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ImagePickerMixin, HomeMixin {
  var logger = Logger();
  final reviewApi = ReviewApi();
  void handleImageSelection(BuildContext context, AssetEntity asset) {
    //logger.d(asset.size);
  }
  List<ReviewAi> reviews = [];
  @override
  void initState() {
    super.initState();
    getReviewList().then((value) {
      setState(() {
        reviews = value;
      });
    });
  }

  void selectImages() async {
    List<AssetEntity>? assets =
        await openPicker(context, 9, handleImageSelection);
    if (assets == null) return;
    uploadAssignments(assets, minioUpload);
  }

  void onTakePictureTapped() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: PageView.builder(
          controller: PageController(initialPage: 1),
          itemCount: 3, // Display 3 days of content
          itemBuilder: (context, index) {
            DateTime currentDate =
                DateTime.now().subtract(Duration(days: 1 - index));
            String formattedDate =
                "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
            return ListView(
              children: [
                Text(formattedDate), // Display the date at the top
                // Add your content here for each day.  This will need to be populated with data based on the date.
                // Example:  Replace this with your actual data fetching and display logic.
                for (var i = 0; i < 10; i++)
                  ListTile(
                    title: Text("Item $i for $formattedDate"),
                  ),
              ],
            );
          },
        ),
        floatingActionButton:
            DraggableButtonWidget(onTap: onTakePictureTapped));
  }
}
