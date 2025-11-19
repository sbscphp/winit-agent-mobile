import 'package:flutter/material.dart';

import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';

class SelectQuantity extends StatefulWidget {
  const SelectQuantity({super.key});

  @override
  State<SelectQuantity> createState() => _SelectQuantityState();
}

class _SelectQuantityState extends State<SelectQuantity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: false,
        useCustomTitleWidget: true,
        titleWidget: RichText(
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
                text: 'Mega Raffle',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
