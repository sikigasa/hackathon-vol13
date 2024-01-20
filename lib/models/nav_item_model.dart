import 'rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: 'Chat',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'CHAT',
      stateMachineName: 'CHAT_Interactivity',
    ),
  ),
  NavItemModel(
    title: 'Search',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
    ),
  ),
  NavItemModel(
    title: 'Home',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'HOME',
      stateMachineName: 'HOME_interactivity',
    ),
  ),
  // NavItemModel(
  //   title: 'Edit-Click',
  //   rive: RiveModel(
  //     src: 'assets/animated-icon-set.riv',
  //     artboard: 'Edit-CLICK',
  //     stateMachineName: 'State-machine',
  //   ),
  // ),
  NavItemModel(
    title: 'Timer',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'TIMER',
      stateMachineName: 'TIMER_Interactivity',
    ),
  ),
  NavItemModel(
    title: 'Settings',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'SETTINGS',
      stateMachineName: 'SETTINGS_Interactivity',
    ),
  ),
];
