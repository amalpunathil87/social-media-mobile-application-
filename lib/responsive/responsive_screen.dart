import 'package:flutter/material.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/utils/global_variable.dart';
import 'package:provider/provider.dart';

class responsivelayout extends StatefulWidget {
  final Widget WebScreenLayout;
  final Widget MobileScreenLayout;

  const responsivelayout(
      {super.key,
      required this.MobileScreenLayout,
      required this.WebScreenLayout});

  @override
  State<responsivelayout> createState() => _responsivelayoutState();
}

class _responsivelayoutState extends State<responsivelayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    userprovider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > WebScreenSize) {
        //web screen
        return widget.WebScreenLayout;
      }
      return widget.MobileScreenLayout;
    });
  }
}
