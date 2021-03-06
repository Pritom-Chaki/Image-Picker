import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_app/screen/camera_package_code.dart';
import 'package:image_picker_app/screen/img_permission.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraPackageCode(),
    );
  }
}

class CameraPackageCode extends StatefulWidget {
  @override
  _CameraPackageCodeState createState() => _CameraPackageCodeState();
}

class _CameraPackageCodeState extends State<CameraPackageCode> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream((image) => {});
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      return Scaffold(
        body: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      );
    } else {
      return Container();
    }
  }
}
