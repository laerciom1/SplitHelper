import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:split_helper/core/presentation/widgets/page_wrapper.dart';
import 'package:split_helper/features/auth/infra/splitwise_authenticator.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  final Uri authUrl;
  final void Function(Uri redirectUri) onRedirect;

  const AuthPage({
    required this.authUrl,
    required this.onRedirect,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(
              SplitwiseAuthenticator.redirectUrl.toString(),
            )) {
              final uri = Uri.parse(request.url);
              final queryParams = uri.queryParameters;
              if (queryParams.containsKey('code')) {
                widget.onRedirect(uri);
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(widget.authUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBar: false,
      child: WebViewWidget(controller: controller),
    );
  }
}
