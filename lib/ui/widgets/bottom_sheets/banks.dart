import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/models/bank.dart';
import 'package:winit_agent/core/data/view_models/utility/banks_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_radio_button.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/text_fields/search_field.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../close_icon.dart';

class Banks extends ConsumerWidget {
  final ValueChanged<Bank> onDone;
  const Banks({super.key, required this.onDone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(banksViewModel);
    return Padding(
      padding: EdgeInsets.only(
        top: 24.h,
        left: 17.w,
        right: 17.w,
        bottom: 16.h
      ),
      child: SafeArea(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Text(
                        'Select a Bank',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textTertiary
                        ),
                      ),

                    ],
                  ),
                ),
                CloseIcon()

              ],
            ),
            SizedBox(height: 24.h,),
            Builder(
              builder: (context) {
                if(vm.state == ViewState.busy){
                  return Expanded(
                    child: Center(
                      child: AppLoader(),
                    ),
                  );
                }

                if(vm.state == ViewState.retrieved){
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchField(
                          hintText: 'Enter Bank name',
                          keyboardType: TextInputType.text,
                          onChanged: (value){
                            if(value.isEmpty){
                              vm.defaultFilterList();
                              return;
                            }
                            vm.filterList(searchWord: value);
                          },
                        ),
                        SizedBox(height: 29.h,),
                        Expanded(
                          child: vm.filteredBanks.isNotEmpty
                              ? ListView.separated(
                            itemCount: vm.filteredBanks.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              final bank = vm.filteredBanks[index];
                              final bankName = bank.name ?? 'N/A';
                              final isSelected = vm.selectedBank?.code == bank.code;
                              return Clickable(
                                onPressed: (){
                                  onDone(bank);
                                  vm.defaultFilterList();
                                  popNavigation(context: context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: ColorPath.athensGrey4, width: 1.w),
                                      borderRadius: BorderRadius.all(Radius.circular(8.r))
                                  ),
                                  child: Row(
                                    children: [
                                      CustomRadioButton(
                                        disableClick: true,
                                        value: isSelected,
                                        onchanged: (value){
                                        },
                                      ),
                                      SizedBox(width: 8.w,),
                                      Expanded(
                                        child:   Text(
                                          bankName,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.textSecondary
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16.h,);
                            },
                          )
                          :Center(
                            child: Text(
                              'No Results',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }

                if(vm.state == ViewState.error){
                  return Expanded(
                    child: Center(
                      child: ErrorState(
                        message: vm.message,
                          onPressed: ()=>vm.fetchBanks()),
                    ),
                  );
                }

                return const SizedBox.shrink();

              }
            )

          ],
        ),
      ),
    );
  }
}
