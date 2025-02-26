import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/selection_button.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final void Function(int index, SelectionButtonData value) onSelected;

  @override
  Widget build(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          // activeIcon: EvaIcons.home,
          // icon: EvaIcons.homeOutline,
          activeIcon: SvgAssets.overview,
          icon: SvgAssets.overview,
          label: "Overview",
        ),
        SelectionButtonData(
          // activeIcon: EvaIcons.swap,
          // icon: EvaIcons.swapOutline,
          activeIcon: SvgAssets.car,
          icon: SvgAssets.car,
          label: "Car Portal",
        ),
        // SelectionButtonData(
        //   // activeIcon: EvaIcons.activity,
        //   // icon: EvaIcons.activityOutline,
        //   activeIcon: SvgAssets.integration,
        //   icon: SvgAssets.integration,
        //   label: "Integrations",
        // ),
        SelectionButtonData(
          // activeIcon: EvaIcons.questionMarkCircle,
          // icon: EvaIcons.questionMarkCircleOutline,
          activeIcon: SvgAssets.settings,
          icon: SvgAssets.settings,
          label: "Settings",
          // totalNotif: 100,
        ),
      ],
      onSelected: onSelected,
    );
  }
}
