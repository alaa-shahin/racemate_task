import '../../core/utils/constants.dart';
import '../../core/widgets/loading_widget.dart';
import '../../index.dart';

class BaseRequest {
  static final GetHttpClient _req = GetHttpClient(
    baseUrl: "${Constants.domainUrl}/api",
    allowAutoSignedCert: true,
  );

  static Future<dynamic> dynamicRequest(
    String path, {
    RequestType requestType = RequestType.get,
    dynamic body,
    bool showDialog = false,
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

    var res = await _req
        .request(
      path,
      requestType.name,
      body: body,
    )
        .catchError((onError) {
      debugPrint(onError.toString());
    });
    if (res.isOk) {
      dismissAllToast();
      debugPrint(res.body['data']);
    } else {
      debugPrint("${res.body}");
      return null;
    }
  }
}

enum RequestType { get, post, put, delete }
