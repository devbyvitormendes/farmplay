import 'package:famplay/presenter/ui/constants/constants.dart';
import 'package:famplay/presenter/ui/famplay_icon.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Image image;
  final String title;
  final bool showBack;
  final bool showLogoff;
  final Color color;
  final Color backgroundColor;

  const AppBarWidget({
    super.key,
    required this.image,
    required this.title,
    required this.showBack,
    required this.showLogoff,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showBack
          ? const EdgeInsets.only(right: 15)
          : const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          AppBar(
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: showBack,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: image.image,
                  color: color,
                  width: 22,
                  height: 22,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: color,
                  ),
                ),
              ],
            ),
            actions: [
              Visibility(
                visible: showLogoff,
                child: IconButton(
                  onPressed: () {
                    //logout();
                    Navigator.of(context).pushNamed('/auth/login');
                  },
                  icon: Icon(
                    FamplayIcons.logout,
                    color: color,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}