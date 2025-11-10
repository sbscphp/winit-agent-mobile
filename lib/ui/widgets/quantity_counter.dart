import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/debouncer.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';

class QuantityCounter extends StatefulWidget {
  final int lowerLimit, upperLimit, stepValue, value;
  final ValueChanged<dynamic> onChanged;
  const QuantityCounter({
    super.key,
    this.value = 1,
    required this.onChanged,
    this.lowerLimit = 1,
    this.upperLimit = 1000000,
    this.stepValue = 1
  });

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {

  final _quantity = TextEditingController();
  final _fn = FocusNode();
  late Debouncer debouncer;

  @override
  void initState() {
    _quantity.text = widget.value.toString();
    debouncer = Debouncer(milliseconds: 400);
    super.initState();
  }

  @override
  void dispose() {
    _fn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Clickable(
          onPressed: (){
            _fn.unfocus();
            if(int.tryParse(_quantity.text) == widget.lowerLimit){
              return;
            }

            setState(() {
              _quantity.text = ((int.tryParse(_quantity.text) ?? 0) - widget.stepValue).toString();
              widget.onChanged(int.tryParse(_quantity.text));
            });

          },
          child: Opacity(
            opacity: int.tryParse(_quantity.text) == widget.lowerLimit ? 0.3 : 1,
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).colorScheme.textPrimary, width: 1.w)
              ),
              child: Center(
                child: CustomSvg(
                  asset:AppAsset.subtract,
                  height: 1.67.h,
                  width: 11.67.w,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.w,),
        Container(
          width: 60.w,
          decoration: BoxDecoration(
            color: ColorPath.hummingBirdBlue2,
            border: Border.all(
              color: ColorPath.easternBlue.withAlpha((255 * 0.16).toInt()),
              width: 1.w
            ),
            borderRadius: BorderRadius.all(Radius.circular(16.r))
          ),
          child: TextFormField(
            showCursor: false,
            controller: _quantity,
            focusNode: _fn,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 36.sp,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.textPrimary,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value){

              debouncer.performAction(action: () async {
                setState(() {
                  if(_quantity.text.isEmpty || value == '0')_quantity.text = '1';
                  _quantity.selection = TextSelection.fromPosition(
                    TextPosition(offset: _quantity.text.length),
                  );
                });
                widget.onChanged(int.tryParse(_quantity.text));
              });

            },
            onFieldSubmitted: (newValue) {

            },
          ),
        ),
        // Center(
        //   child: Text(
        //     value.toString(),
        //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
        //       fontSize: 36.sp,
        //         fontWeight: FontWeight.w800,
        //         color:
        //         Theme.of(context).colorScheme.textPrimary),
        //   ),
        // ),
        SizedBox(width: 15.w,),
        Clickable(
          onPressed: (){
            _fn.unfocus();
            if(int.tryParse(_quantity.text) == widget.upperLimit){
              return;
            }
            setState(() {
              _quantity.text = ((int.tryParse(_quantity.text) ?? 0) + widget.stepValue).toString();
            });
            widget.onChanged(int.tryParse(_quantity.text));
          },
          child: Opacity(
            opacity: int.tryParse(_quantity.text) == widget.upperLimit ? 0.3 : 1,
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.textPrimary, width: 1.w)
              ),
              child: Center(
                child: CustomSvg(
                  asset:AppAsset.add,
                  height: 11.67.h,
                  width: 11.67.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
