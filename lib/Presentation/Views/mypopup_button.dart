import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/Config/size.dart';
import 'package:timer/Presentation/Views/popup_menu_item.dart';
import 'package:timer/Providers/home_provider.dart';

class MyPopUpButton extends StatelessWidget {
  const MyPopUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        size: SizeConfig.textMultiplier * 4,
        color: Colors.white,
      ),
      onSelected: (noOfDays) {
        context.read<HomeProvider>().changeChallengeNoOfDays(noOfDays);
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(child: PopupMenuItemWidget(title: '2 Days', value: 2)),
          PopupMenuItem(child: PopupMenuItemWidget(title: '4 Days', value: 4)),
          PopupMenuItem(child: PopupMenuItemWidget(title: '7 Days', value: 7)),
          PopupMenuItem(
              child: PopupMenuItemWidget(title: '10 Days', value: 10)),
          PopupMenuItem(
              child: PopupMenuItemWidget(title: '20 Days', value: 20)),
          PopupMenuItem(
              child: PopupMenuItemWidget(title: '30 Days', value: 30)),
        ];
      },
    );
  }

}
