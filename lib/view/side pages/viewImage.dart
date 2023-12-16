import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: false, // Set it to false
          // boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 5,
          child: Image.network(
            Get.arguments["imageLink"],
          ),
        ),
      ),
    );
  }
}
