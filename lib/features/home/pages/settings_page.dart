import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';

class Scnren extends StatefulWidget {
  final String njfkds;
  final String njfkads;
  final String mkda;

  Scnren({
    required this.njfkds,
    required this.njfkads,
    required this.mkda,
  });

  @override
  State<Scnren> createState() => _ScnrenState();
}

class _ScnrenState extends State<Scnren> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  String paramsFirst = '';
  final InAppReview inAppReview = InAppReview.instance;
  String paramsSecond = '';
  Map _deepLinkData = {};
  Map _gcd = {};
  bool _isFirstLaunch = false;
  String _afStatus = '';
  String _campaign = '';
  String _campaignId = '';

  @override
  void initState() {
    super.initState();
    getTracking();
    afStart();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fetchData() async {
    adId = await AppTrackingTransparency.getAdvertisingIdentifier();
  }

  void afStart() async {
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
      setState(() {
        _deepLinkData = res;
        paramsSecond = res['payload']
            .entries
            .where((e) => ![
                  'install_time',
                  'click_time',
                  'af_status',
                  'is_first_launch'
                ].contains(e.key))
            .map((e) => '&${e.key}=${e.value}')
            .join();
        // Extract media source and campaign name
        _campaign = res['campaign'] ?? '';
        _campaignId = res['media_source'] ?? '';
      });
    });

    _appsflyerSdk.onInstallConversionData((res) {
      print(res);
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
        // Extract media source and campaign name
        _campaign = res['campaign'] ?? '';
        _campaignId = res['media_source'] ?? '';
      });
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String ajx =
        '${widget.njfkds}&appsflyer_id=${widget.njfkads}${widget.mkda}&media_source=$_campaignId&campaign=$_campaign';
    print(ajx);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(ajx),
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar('Settings'),
          const SizedBox(height: 50),
          _SettingsTile(
            asset: 's1',
            title: 'Share with friends',
            onTap: () => _shareApp(
                'Check out the Vendi app! https://apps.apple.com/app/vendi-first-machine'),
          ),
          const _Divider(),
          _SettingsTile(
            asset: 's2',
            title: 'Terms of Use',
            onTap: () => _launchUrl(
                'https://docs.google.com/document/d/1AEQ0_UNau0rL9Y_YbKSMtg1tCSlw8mMUXthgb5A-898/edit?usp=sharing'),
          ),
          const _Divider(),
          _SettingsTile(
            asset: 's3',
            title: 'Contact Support',
            onTap: () => _launchUrl('https://www.example.com/support'),
          ),
          const _Divider(),
          _SettingsTile(
            asset: 's4',
            title: 'Privacy Policy',
            onTap: () => _launchUrl(
                'https://docs.google.com/document/d/19UpH0H2Edubrnm7oQkl8nTJpMI5e6DTem4jVsgDprDc/edit?usp=sharing'),
          ),
          const _Divider(),
          const Spacer(),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _shareApp(String message) {
    Share.share(message);
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.asset,
    required this.title,
    this.notification = false,
    this.onTap,
  });

  final String asset;
  final String title;
  final bool notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: CupertinoButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SizedBox(width: 20),
            SvgPicture.asset('assets/$asset.svg'),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFM',
              ),
            ),
            const Spacer(),
            if (notification) const _Switch(),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      margin: const EdgeInsets.only(
        left: 20,
        right: 14,
      ),
      color: AppColors.main,
    );
  }
}

class _Switch extends StatefulWidget {
  const _Switch();

  @override
  State<_Switch> createState() => __SwitchState();
}

class __SwitchState extends State<_Switch> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          active = !active;
        });
      },
      padding: EdgeInsets.zero,
      minSize: 31,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 51,
        height: 31,
        decoration: BoxDecoration(
          color: active ? AppColors.main : Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: 2,
              left: active ? 22 : 2,
              child: Container(
                height: 27,
                width: 27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
