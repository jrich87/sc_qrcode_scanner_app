
import 'package:flutter/material.dart';
import 'package:sc_qrcode_scanner_app/styling/common_styles.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showSwitchCameraIcon;
  final VoidCallback? onSwitchCamera;

  CustomAppBarWidget({this.showSwitchCameraIcon = false, this.onSwitchCamera});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100.0,
          width: 100.0,
          child: Image.asset('assets/sportcheklogo.png'),
        )
      ),
      title: const Text(
          'QR Code Scanner',
          style: CommonStyles.appBarTitle
      ),
      backgroundColor: CommonColors.appBarBackground,
      actions: showSwitchCameraIcon ? [
        IconButton(
          onPressed: onSwitchCamera,
          icon: const Icon(Icons.camera_rear_outlined, color: Colors.white),
        ),
      ] : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}