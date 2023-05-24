import 'dart:io';

import 'package:flutter/material.dart';
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/custom_border_radius.dart';
import 'package:property_app/constants/custom_sizes.dart';
import 'package:property_app/controllers/item_controller.dart';
import 'package:property_app/services/screeSize.dart';
import 'package:image_picker/image_picker.dart';

File? imageFile;

void showOverlay(BuildContext context) async {
  final screenSize = getScreenSize(context);

  if (image?.path != null) {
    imageFile = File(image!.path);
  }

  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry? overlay;

  void removeOverlay() {
    overlay?.remove();
  }

  overlay = OverlayEntry(builder: (context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CustomBorderRadius.lg_16),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: screenSize.height * 0.55,
            width: screenSize.width * 0.80,
            child: Container(
              padding: const EdgeInsets.all(CustomSizes.size_15),
              decoration: BoxDecoration(
                  color: CustomColor.customBlack,
                  borderRadius:
                      BorderRadius.circular(CustomBorderRadius.md_12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeOverlay();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: CustomColor.customWhite),
                              color: CustomColor.customBlack,
                              borderRadius: BorderRadius.circular(
                                  CustomBorderRadius.sm_08)),
                          child: const Center(
                            child: Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: CustomSizes.size_15),
                    child: SizedBox(
                      height: CustomSizes.size_250,
                      width: CustomSizes.size_250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          imageWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
  overlayState?.insertAll([overlay]);
}

class imageWidget extends StatefulWidget {
  const imageWidget({super.key});

  @override
  _imageWidgetState createState() => _imageWidgetState();
}

/*class _imageWidgetState extends State<imageWidget> {
  Widget displayedImage = const Icon(Icons.image_search_rounded);
  File imageFile = File(image!.path);

  @override
  void initState() {
    super.initState();
    imageFile = File(image!.path);
    if (imageFile != null) {
      displayedImage = Image.file(
        imageFile,
        width: CustomSizes.size_250,
        height: CustomSizes.size_250,
        fit: BoxFit.cover,
      );
    }
  }

  void updateImage() {
    setState(() {
      displayedImage = Image.file(
        imageFile,
        width: CustomSizes.size_250,
        height: CustomSizes.size_250,
        fit: BoxFit.cover,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        imageFile = await selectImage();
        updateImage();
      },
      child: displayedImage,
    );
  }
}*/

class _imageWidgetState extends State<imageWidget> {
  var displayedImage = imageFile != null
      ? Image.file(
          imageFile!,
          width: CustomSizes.size_250,
          height: CustomSizes.size_250,
          fit: BoxFit.cover,
        )
      : const Icon(Icons.image_search_rounded);
  void updateImage() {
    setState(() {
      displayedImage = imageFile as Widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        image = selectImage();
        imageFile = File(image!.path);
        updateImage();
      },
      child: displayedImage,
    );
  }
}




/*
void showOverlay(BuildContext context) async {
  final screenSize = getScreenSize(context);
  File? imageFile;

  if (image?.path != null) {
    imageFile = File(image!.path);
  }

  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry? overlay;

  void removeOverlay() {
    overlay?.remove();
  }

  overlay = OverlayEntry(builder: (context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CustomBorderRadius.lg_16),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: screenSize.height * 0.55,
            width: screenSize.width * 0.80,
            child: Container(
              padding: const EdgeInsets.all(CustomSizes.size_15),
              decoration: BoxDecoration(
                  color: CustomColor.customBlack,
                  borderRadius:
                      BorderRadius.circular(CustomBorderRadius.md_12)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          removeOverlay();
                        },
                        child: Container(
                          //padding: const EdgeInsets.all(CustomSizes.size_15),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: CustomColor.customWhite),
                              color: CustomColor.customBlack,
                              borderRadius: BorderRadius.circular(
                                  CustomBorderRadius.sm_08)),
                          child: const Center(
                            child: Icon(Icons.close_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: CustomSizes.size_15),
                    child: SizedBox(
                      height: CustomSizes.size_250,
                      width: CustomSizes.size_250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: imageFile != null
                                ? Image.file(
                                    imageFile!,
                                    width: CustomSizes.size_250,
                                    height: CustomSizes.size_250,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image_search_rounded),
                            onTap: () async {
                              image = selectImage();
                              imageFile = File(image!.path);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
  overlayState?.insertAll([overlay]);
}*/
