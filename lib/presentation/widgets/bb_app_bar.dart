import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BbAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BbAppBar({
    super.key,
  });
  @override
      Size get preferredSize => const Size.fromHeight(kToolbarHeight);  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Row(mainAxisAlignment: .center,
          
          children: [
            SvgPicture.asset('assets/images/BlackBull_w.svg', height: 32),
                        ],
        ),
      ),
    );
  }
}