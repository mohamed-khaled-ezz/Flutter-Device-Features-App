import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

/// Screen that displays the device model name and operating system version.
class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  String _deviceModel = 'Loading...';
  String _osVersion = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDeviceInfo();
  }

  /// Retrieves runtime hardware and OS information using the device_info_plus package.
  Future<void> _fetchDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo =
            await deviceInfoPlugin.androidInfo;
        setState(() {
          _deviceModel = androidInfo.model;
          _osVersion =
              'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
          _isLoading = false;
        });
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        setState(() {
          _deviceModel = iosInfo.utsname.machine;
          _osVersion = 'iOS ${iosInfo.systemVersion}';
          _isLoading = false;
        });
      } else {
        final BaseDeviceInfo genericInfo = await deviceInfoPlugin.deviceInfo;
        setState(() {
          _deviceModel =
              genericInfo.data['model']?.toString() ?? 'Unknown Model';
          _osVersion =
              genericInfo.data['osVersion']?.toString() ?? 'Unknown OS';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _deviceModel = 'Failed to load device info';
        _osVersion = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Info')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Model: $_deviceModel\nOS Version: $_osVersion',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
      ),
    );
  }
}
