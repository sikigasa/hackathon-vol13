import 'rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: 'Home',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'Home',
      stateMachineName: 'State Machine 1',
    ),
  ),
  NavItemModel(
    title: 'Cameras',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'Cameras',
      stateMachineName: 'State Machine 1',
    ),
  ),
  NavItemModel(
    title: 'Gallery',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'Gallery',
      stateMachineName: 'State Machine 1',
    ),
  ),
  NavItemModel(
    title: 'Settings',
    rive: RiveModel(
      src: 'assets/animated-icons-color.riv',
      artboard: 'Settings',
      stateMachineName: 'State Machine 1',
    ),
  ),
];
