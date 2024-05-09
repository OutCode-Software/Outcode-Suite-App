import 'dart:async';

import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/utils/strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../flavor_config.dart';
import '../../constants/constants.dart';
import '../../utils/app_styles.dart';
import '../image_widgets/app_image_view.dart';

class NoInternetConnectivityWrapper extends StatefulWidget {
  const NoInternetConnectivityWrapper({required this.child, super.key});
  final Widget child;

  @override
  _NoInternetConnectivityWrapperState createState() =>
      _NoInternetConnectivityWrapperState();
}

class _NoInternetConnectivityWrapperState
    extends State<NoInternetConnectivityWrapper> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool hasInternet = true;
  @override
  void initState() {
    _setInitialValues();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      // Got a new connectivity status!
      Future.delayed(const Duration(seconds: 1), _setInitialValues);
    }) as StreamSubscription<ConnectivityResult>;
    super.initState();
  }

  Future<void> _setInitialValues() async {
    hasInternet =
        (await Connectivity().checkConnectivity()) != ConnectivityResult.none;
    setState(() {});
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          widget.child,
          Visibility(
              visible:
                  !hasInternet && Constants.showsInternetConnectivitySheild,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              bottom: (hasInternet && Constants.showsInternetConnectivitySheild)
                  ? -300
                  : 0,
              height: 300,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                alignment: Alignment.bottomCenter,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImageView(
                      placeholderHeight: 150,
                      placeholderImage: FlavorConfig.appIconImage(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'NoInternetConnection'.localized,
                        style: AppStyles.boldExtraLarge(),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
