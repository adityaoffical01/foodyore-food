import 'package:flutter/material.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_screen_background.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SearchWidget')),
      body: CustomBackground(
        child: Column(children: [Center(child: Text('MyOrderWidget'))]),
      ),
    );
  }
}
