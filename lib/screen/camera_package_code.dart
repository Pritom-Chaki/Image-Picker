import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

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
