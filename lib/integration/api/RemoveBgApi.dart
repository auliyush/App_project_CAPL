import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class RemoveBgApi {
  final String apiKey = "BEySBWmGKp4h96xbP9rvkrLZ";

  // Overloaded method to handle Uint8List
  Future<Uint8List> removeBg(Uint8List imageBytes) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg"),
    );

    // Create a multipart file from Uint8List
    request.files.add(http.MultipartFile.fromBytes(
      "image_file",
      imageBytes,
      filename: 'image.png', // Provide a name for the image
      contentType: MediaType('image', 'png'), // Change as necessary
    ));

    request.headers.addAll({"X-API-Key": apiKey});

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        http.Response imgRes = await http.Response.fromStream(response);
        return imgRes.bodyBytes;
      } else {
        throw Exception("Error occurred: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Failed to remove background: $e");
    }
  }

  // Original method to handle String paths (for mobile)
  Future<Uint8List> removeBgFromPath(String imagePath) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg"),
    );

    request.files.add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": apiKey});

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        http.Response imgRes = await http.Response.fromStream(response);
        return imgRes.bodyBytes;
      } else {
        throw Exception("Error occurred: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Failed to remove background: $e");
    }
  }
}