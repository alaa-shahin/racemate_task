import 'dart:convert';
import 'package:flutter/services.dart';
import '../../core/utils/constants.dart';
import '../../core/widgets/loading_widget.dart';
import '../../index.dart';

class BaseRequest {
  static Future<dynamic> dynamicRequest({
    String? path,
    RequestType requestType = RequestType.get,
    dynamic body,
    bool showDialog = true,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((s) async {
      if (showDialog) {
        showToastWidget(
          const LoadingWidget(),
          duration: const Duration(
            seconds: 3,
          ),
          dismissOtherToast: true,
        );
      }
    });
    final String response = await rootBundle.loadString(Constants.domainUrl);
    final data = await json.decode(response);
    if (data['items'] != null) {
      dismissAllToast();
      return data['items'];
    } else {
      debugPrint("Error $data");
      return null;
    }
  }
}

enum RequestType { get, post, put, delete }
