import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  final logger = Logger(printer: PrettyPrinter());
  final dio = Dio();

  String _text = "this is a blank page";

  @override
  void initState() {
    super.initState();
    this.checkInternetConnection().then((val) async {
      logger.d(val);
      setState(() {
        _text = val;
        logger.d(_text);
      });
      var resp = await dio.post("http://192.168.0.123:3300/minio/get_access_key", data: {"objectName":"h.jpg"});
      _text = resp.toString();
      setState(() {
        _text = resp.toString();
        logger.d(_text);
      });
    });
  }

  Future<String> checkInternetConnection() async {
    var resp = await dio.get("https://www.baidu.com");
    return resp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blank Page'),
      ),
      body:  Center(
        child: Text(_text),
      ),
    );
  }
}
