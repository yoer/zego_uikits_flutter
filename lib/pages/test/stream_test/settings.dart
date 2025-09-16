// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:zego_uikits_demo/data/translations.dart';

class StreamTestSettingsWidget extends StatelessWidget {
  final TextEditingController roomIdController;
  final TextEditingController localUserIdController;
  final TextEditingController localUserNameController;
  final TextEditingController localStreamIdController;
  final TextEditingController remoteUserIdController;
  final TextEditingController remoteUserNameController;
  final TextEditingController remoteStreamIdController;
  final bool turnOnCamera;
  final bool turnOnMicrophone;
  final ValueChanged<bool> onCameraChanged;
  final ValueChanged<bool> onMicrophoneChanged;
  final TabController tabController;

  const StreamTestSettingsWidget({
    super.key,
    required this.roomIdController,
    required this.localUserIdController,
    required this.localUserNameController,
    required this.localStreamIdController,
    required this.remoteUserIdController,
    required this.remoteUserNameController,
    required this.remoteStreamIdController,
    required this.turnOnCamera,
    required this.turnOnMicrophone,
    required this.onCameraChanged,
    required this.onMicrophoneChanged,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextField(
            controller: roomIdController,
            decoration: InputDecoration(
              labelText: '${Translations.streamTest.roomId} *',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
          SizedBox(height: 16.r),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _buildLocalStreamTab(),
                _buildRemoteStreamTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocalStreamTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.streamTest.localStream,
            style: TextStyle(
              fontSize: 20.r,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.r),

          // Local User ID
          TextField(
            controller: localUserIdController,
            decoration: InputDecoration(
              labelText: '${Translations.streamTest.localUserId} *',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
          SizedBox(height: 22.r),

          // Local User Name
          TextField(
            controller: localUserNameController,
            decoration: InputDecoration(
              labelText: '${Translations.streamTest.localUserName} *',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
          SizedBox(height: 22.r),

          // Local Stream ID
          TextField(
            controller: localStreamIdController,
            decoration: InputDecoration(
              labelText: Translations.streamTest.localStreamId,
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
          SizedBox(height: 20.r),

          // Camera Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translations.streamTest.turnOnCamera,
                style: TextStyle(
                  fontSize: 22.r,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: turnOnCamera,
                onChanged: onCameraChanged,
              ),
            ],
          ),
          SizedBox(height: 22.r),

          // Microphone Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translations.streamTest.turnOnMicrophone,
                style: TextStyle(
                  fontSize: 22.r,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: turnOnMicrophone,
                onChanged: onMicrophoneChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRemoteStreamTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.streamTest.remoteStream,
            style: TextStyle(
              fontSize: 20.r,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.r),

          // Remote User ID
          TextField(
            controller: remoteUserIdController,
            decoration: InputDecoration(
              labelText: Translations.streamTest.remoteUserId,
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
          SizedBox(height: 22.r),

          // Remote User Name
          TextField(
            controller: remoteUserNameController,
            decoration: InputDecoration(
              labelText: Translations.streamTest.remoteUserName,
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
          SizedBox(height: 22.r),

          // Remote Stream ID
          TextField(
            controller: remoteStreamIdController,
            decoration: InputDecoration(
              labelText: Translations.streamTest.remoteStreamId,
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 22.r),
          ),
        ],
      ),
    );
  }
}
