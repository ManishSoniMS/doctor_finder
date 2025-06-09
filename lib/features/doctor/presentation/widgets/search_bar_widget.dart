import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/app_style.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for doctor',
          hintStyle: AppStyles.normalTextStyle.copyWith(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.search, size: 30, color: Colors.black),
          border: OutlineInputBorder(
            gapPadding: 10,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppStyles.mainColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
