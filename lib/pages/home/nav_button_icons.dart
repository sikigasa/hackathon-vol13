import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_vol13/models/nav_item_model.dart';
import 'package:rive/rive.dart';

const Color buttonNavBgColor = Color(0xFF17203A);

class ButtonNavWithIcons extends StatefulWidget {
  const ButtonNavWithIcons({super.key});

  @override
  State<ButtonNavWithIcons> createState() => _ButtonNavWithIconsState();
}

class _ButtonNavWithIconsState extends State<ButtonNavWithIcons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 56,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24), //横幅
          decoration: BoxDecoration(
            color: buttonNavBgColor.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: Row(
            children: List.generate(
              bottomNavItems.length,
              (index) => SizedBox(
                width: 36,
                height: 36,
                child: RiveAnimation.asset(
                  bottomNavItems[index].rive.src,
                  artboard: bottomNavItems[index].rive.artboard,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
