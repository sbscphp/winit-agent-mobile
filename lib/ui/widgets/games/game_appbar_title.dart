import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/view_models/games/selected_game_vm.dart';

import '../../../core/constants/color_path.dart';

class GameAppbarTitle extends ConsumerWidget {
  const GameAppbarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(selectedGameViewModel);
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color:  ColorPath.turquoiseGreen,
        ),
        children: [
          TextSpan(
            text: 'Buy Ticket: ',
          ),
          TextSpan(
            text: vm.name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
          ),

        ],
      ),
    );
  }
}
