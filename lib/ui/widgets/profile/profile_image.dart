import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';

import '../display_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppDimension.paddingLeft),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Consumer(
          builder: (context, ref, child){
            final vm = ref.watch(profileViewModel);
            return DisplayImage(
              imageUrl: vm.avatar,
              firstName: vm.firstname,
              lastName: vm.lastname,
              initialsSize: 16,
              size: 32,
            );
          },
        ),
      ),
    );
  }
}
