import 'package:face_filters/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'dart:io' as Platform;
import 'package:avatar_view/avatar_view.dart';
import '../secrets.dart';
import '../widgets/error.dart';

class CameraMasksFilters extends StatefulWidget {
  const CameraMasksFilters({Key? key}) : super(key: key);

  @override
  _CameraMasksFiltersState createState() => _CameraMasksFiltersState();
}

class _CameraMasksFiltersState extends State<CameraMasksFilters> {
  // camera controller
  late CameraDeepArController _cameraDeepArController;
  String platformVersion = "Unknown";
  String imagePath = "Unknown";
  int currentPage = 0;
  final vp = PageController(viewportFraction: 24);

  // effects, filters and masks
  Effects currentEffects = Effects.none;
  Filters currentFilters = Filters.none;
  Masks currentMasks = Masks.none;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Deep AR Camera
            CameraDeepAr(
              androidLicenceKey: AndroidLicenseKey,
              onCameraReady: (isReady) {
                platformVersion = "Camera status $isReady";
                // print(platformVersion);
                setState(() {});
              },
              onImageCaptured: (path) {
                imagePath = "Image saved at $path";
                showDialog(
                  context: context,
                  builder: (ctx) => AlertBoxWidget(path: imagePath),
                );
                // print(platformVersion);
                setState(() {});
              },
              cameraDeepArCallback: (c) async {
                _cameraDeepArController = c;
                setState(() {});
              },
            ),
            // Face Mask filters - IconButtons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 28,
                        right: 28,
                      ),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.deepPurpleAccent,
                            child: IconButton(
                              splashColor: Colors.blueAccent,
                              iconSize: 50,
                              onPressed: () {
                                if (_cameraDeepArController == null) {
                                  return;
                                }
                                _cameraDeepArController.snapPhoto();
                              },
                              icon: const Icon(
                                Icons.camera_enhance,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(8, (page) {
                          bool active = currentPage == page;

                          return Platform.Platform.isIOS
                              // ios
                              ? GestureDetector(
                                  child: AvatarView(
                                    radius: active ? 65 : 30,
                                    borderColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath:
                                        "assets/ios/${page.toString()}.jpg",
                                    placeHolder: const Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    errorWidget: const ErrorIcon(),
                                  ),
                                  onTap: () {
                                    currentPage = page;
                                    _cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                )
                              // android
                              : GestureDetector(
                                  child: AvatarView(
                                    radius: active ? 45 : 25,
                                    borderColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath:
                                        "assets/android/${page.toString()}.jpg",
                                    placeHolder: const Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    errorWidget: const ErrorIcon(),
                                  ),
                                  onTap: () {
                                    currentPage = page;
                                    _cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
