// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saimart/pushNotificationsAPI_firebase/firebase_notifications_api.dart';
import '../widgets_and_screens/no_internet_widget.dart';
import '../constant.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late WebViewController webViewController;
  bool netState = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
    checkInternetConnection();
  }

  void setLoaderTime() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future checkInternetConnection() async {
    final connectionStatus = await (Connectivity().checkConnectivity());
    if (connectionStatus == ConnectivityResult.none) {
      setState(() {
        netState = false;
      });
    } else {
      setState(() {
        netState = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Scaffold(
          body: netState
              ? Stack(
                  children: [
                    WebView(
                      navigationDelegate: (NavigationRequest request) {
                        if (request.url.startsWith("https://saimart.in/")) {
                          return NavigationDecision.navigate;
                        } else {
                          _launchURL(request.url);
                          return NavigationDecision.prevent;
                        }
                      },
                      gestureNavigationEnabled: false,
                      initialUrl: url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        this.webViewController = webViewController;
                      },
                      zoomEnabled: false,
                      onPageStarted: (url) {
                        setState(() {
                          isLoading = true;
                        });
                      },
                      onProgress: (progress) {},
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },

                      // ignore: prefer_collection_literals
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : Container()
                  ],
                )
              : const NoInternetWidget(),
        ),
      ),
    );
  }

//Exit app dialog
  Future<bool> _goBack(BuildContext context) async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return Future.value(false);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Do you want to Exit?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('NO', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child:
                        const Text('YES', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
