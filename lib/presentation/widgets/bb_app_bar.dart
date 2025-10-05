import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const BbAppBar({super.key , this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/images/BlackBull_w.svg', height: 32),
            if(title != null) Text( title!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white), textAlign: .left,),
          ],
        ),
      ),
    );
  }
}
