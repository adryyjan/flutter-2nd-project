import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import '../widgets/photo_to_accept.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print("Błąd inicjalizacji kamery: $e");
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) return;

    try {
      final XFile image = await _cameraController!.takePicture();
      print("Zdjęcie zapisane w: ${image.path}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Zdjęcie zapisane!"),
          duration: Duration(milliseconds: 900),
        ),
      );
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(
            imagePath: image.path,
            isPrivate: false,
          ),
        ),
      );
    } catch (e) {
      print("Błąd robienia zdjęcia: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        Container(
          width: DIALOG_WIDTH(context),
          height: DIALOG_HIGHT(context),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: _isCameraInitialized
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: FloatingActionButton(
              onPressed: _takePicture,
              backgroundColor: Colors.white,
              child: Icon(Icons.camera, color: Colors.black),
            ),
          ),
        )
      ]),
    );
  }
}
