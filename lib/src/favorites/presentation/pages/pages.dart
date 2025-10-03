import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 34,

        leading: SvgPicture.asset('assets/images/BlackBullIco.svg'),

        title: Text('Favorites Page'),
      ),
    );
  }
}
