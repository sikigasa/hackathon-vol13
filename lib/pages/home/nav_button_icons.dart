import 'dart:async';

// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_vol13/models/nav_item_model.dart';
import 'package:hackathon_vol13/pages/input/input_page.dart';
import 'package:hackathon_vol13/pages/home/home_page.dart';
import 'package:hackathon_vol13/pages/home/settings_page.dart';
import 'package:hackathon_vol13/database/wallet.dart';
import 'package:rive/rive.dart';

const Color buttonNavBgColor = Color(0xFF17203A);

class ButtonNavWithIcons extends StatefulWidget {
  final AppDatabase database;
  const ButtonNavWithIcons({super.key, required this.database});

  @override
  State<ButtonNavWithIcons> createState() => _ButtonNavWithIconsState();
}

class _ButtonNavWithIconsState extends State<ButtonNavWithIcons> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selectedNavIndex = 0;
  List<String> pages = [
    // HomePage(),
    "Home",
    "Input",
    "Camera",
    "Profile",
    "Settings",
  ];

  void animateIcon(int index) {
    riveIconInputs[index].change(true);
    Future.delayed(const Duration(milliseconds: 800), () {
      riveIconInputs[index].change(false);
    });
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    if (controller != null) {
      artboard.addController(controller);
      controllers.add(controller);
      riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<WidgetBuilder> pageOptions = [
      (BuildContext context) => HomePage(
            database: widget.database,
          ),
      (BuildContext context) => HomePage(
            database: widget.database,
          ),
      (BuildContext context) => HomePage(
            database: widget.database,
          ),
      (BuildContext context) => HomePage(
            database: widget.database,
          ),
      (BuildContext context) => SettingsPage(),
    ];

    return Scaffold(
      body: pageOptions[selectedNavIndex](context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TakePictureScreen(
                database: widget.database,
              ),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 66,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 16), //横幅
          decoration: BoxDecoration(
            color: buttonNavBgColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 20,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomNavItems.length,
              (index) {
                final riveIcon = bottomNavItems[index].rive;
                return GestureDetector(
                  onTap: () {
                    animateIcon(index);
                    setState(() {
                      selectedNavIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                        isActive: selectedNavIndex == index,
                      ),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Opacity(
                          opacity: selectedNavIndex == index ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            riveIcon.src,
                            artboard: riveIcon.artboard,
                            onInit: (artboard) {
                              riveOnInit(artboard,
                                  stateMachineName: riveIcon.stateMachineName);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class listwidget extends StatelessWidget {
//   const listwidget({
//     super.key,
//     required this.pages,
//     required this.selectedNavIndex,
//   });

//   final List<String> pages;
//   final int selectedNavIndex;

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text(pages[selectedNavIndex]));
//   }
// }

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 61, 77, 126),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}
