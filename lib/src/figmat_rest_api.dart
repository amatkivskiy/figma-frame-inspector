import 'dart:io';

import 'package:dio/dio.dart';

class FigmaRestApi {
  const FigmaRestApi._();

  static Future<String> downloadFrameImage({
    required String figmatToken,
    required String figmaframeUrl,
    required double imageScale,
  }) async {
    return _parseNodeId(figmaframeUrl).then((figmaParams) {
      return Dio(
        BaseOptions(
          baseUrl: "https://api.figma.com",
          headers: {
            'X-Figma-Token': figmatToken,
            'Accept': 'application/json',
          },
        ),
      ).get(
        '/v1/images/${figmaParams.fileKey}',
        queryParameters: {
          'ids': figmaParams.nodeId,
          'scale': imageScale,
        },
      ).then(
        (value) => _handleResponse(value, figmaParams.nodeId),
      );
    });
  }

  static Future<String> _handleResponse(
      Response httpResponse, String nodeId) async {
    if (httpResponse.statusCode! >= 200 && httpResponse.statusCode! < 300) {
      final responseJson = httpResponse.data;

      if (responseJson['err'] != null) {
        return Future.error(FigmaApiError(responseJson['err']));
      }

      final images = responseJson['images'];
      if (!images.containsKey(nodeId)) {
        return Future.error(FigmaApiError("Node ID ('$nodeId') not found."));
      }

      return images[nodeId]!;
    } else {
      throw HttpException(
        "Failed to load image: ${httpResponse.statusMessage}",
        uri: httpResponse.realUri,
      );
    }
  }

  static Future<FigmaImageRequestData> _parseNodeId(String frameUrl) {
    final uri = Uri.tryParse(frameUrl);

    if (uri == null) {
      return Future.error(_createFrameUrlError);
    }

    final queryParameters = uri.queryParameters;

    if (!queryParameters.containsKey('node-id')) {
      return Future.error(_createFrameUrlError);
    }

    final nodeId = queryParameters['node-id']!;
    final fileKey = uri.pathSegments[1];

    return Future.value(FigmaImageRequestData(
      nodeId: nodeId,
      fileKey: fileKey,
    ));
  }

  static FigmaApiError _createFrameUrlError(String frameUrl) => FigmaApiError(
        "Invalid frame URL: $frameUrl. Should like this: 'https://www.figma.com/file/<file-key>/<figma-file-name>?node-id=<node-id>'",
      );
}

class FigmaImageRequestData {
  FigmaImageRequestData({required this.nodeId, required this.fileKey});

  final String nodeId;
  final String fileKey;
}

class FigmaApiError {
  FigmaApiError(this.message);

  final String message;
}
