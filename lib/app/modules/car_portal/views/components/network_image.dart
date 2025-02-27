import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioImageWidget extends StatefulWidget {
  final String imageUrl;

  const DioImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _DioImageWidgetState createState() => _DioImageWidgetState();
}

class _DioImageWidgetState extends State<DioImageWidget> {
  Uint8List? imageBytes;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
    try {
      var response = await Dio().get(
        widget.imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      setState(() {
        imageBytes = Uint8List.fromList(response.data);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      debugPrint("Image fetch error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator(); // Show a loader while fetching
    }
    if (hasError || imageBytes == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network('ttps://images.pexels.com/photos/919073/pexels-photo-919073.jpeg?auto=compress&cs=tinysrgb&w=1200', fit: BoxFit.cover,  height: 200,
                              width: 200,),
      ); // Fallback image
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.memory(imageBytes!, fit: BoxFit.cover,  height: 200,
                              width: 200,),
    );
  }
}
