import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/onboarding/registration_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/terms_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import 'onboarding_successful.dart';

class Terms extends ConsumerStatefulWidget {
  const Terms({super.key});

  @override
  ConsumerState<Terms> createState() => _TermsState();
}

class _TermsState extends ConsumerState<Terms> {

  bool _accept = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(termsViewModel).fetchTerms();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(termsViewModel);
    final registrationVm = ref.watch(registrationViewModel);
    return BusyOverlay(
      show: registrationVm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Terms and Conditions',
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
            child: Builder(
              builder: (context) {
                if(vm.state == ViewState.busy){
                  return Center(
                    child: AppLoader(),
                  );
                }

                if(vm.state == ViewState.retrieved){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ScreenTitle(title: 'Add Bank Account Information',
                              //     subtitle: 'You can only add a maximum of two (2) bank accounts.'
                              // ),
                              // SizedBox(height: 32.h,),
                              Html(
                                data: vm.terms,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(16),
                                    lineHeight: const LineHeight(1.6),
                                    margin: Margins.zero,
                                    padding: HtmlPaddings.zero,
                                    fontFamily: 'MontserratAlternates',
                                    alignment: Alignment.topCenter,
                                  ),
                                  "h1": Style(
                                    fontSize: FontSize(22),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'MontserratAlternates',
                                    color: Theme.of(context).colorScheme.textPrimary,
                                    margin: Margins.only(bottom: 12, top: 4),
                                    padding: HtmlPaddings.only(bottom: 0),
                                    border: const Border(
                                      bottom: BorderSide(width: 2, color: Colors.transparent),
                                    ),
                                  ),
                                  "h2": Style(
                                    fontSize: FontSize(14.sp),
                                    fontWeight: FontWeight.w700,
                                    color: ColorPath.blueBlue,
                                    fontFamily: 'MontserratAlternates',
                                    margin: Margins.only(top: 16, bottom: 8),
                                  ),
                                  "p": Style(
                                    fontSize: FontSize(14),
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textSecondary,
                                    fontFamily: 'MontserratAlternates',
                                    margin: Margins.only(bottom: 10),
                                  ),
                                  "ul": Style(
                                    padding: HtmlPaddings.only(left: 20),
                                    margin: Margins.only(bottom: 10),
                                  ),
                                  "ol": Style(
                                    padding: HtmlPaddings.only(left: 20),
                                    margin: Margins.only(bottom: 10),
                                  ),
                                  "li": Style(
                                    fontSize: FontSize(14),
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textSecondary,
                                    margin: Margins.only(bottom: 8),
                                  ),
                                  "strong": Style(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: FontSize(14.sp),
                                    fontWeight: FontWeight.w700,
                                    color: ColorPath.blueBlue,
                                    fontFamily: 'MontserratAlternates',
                                    margin: Margins.only(top: 16, bottom: 8),
                                  ),
                                  ".section": Style(
                                    // margin: Margins.only(bottom: 30),
                                    fontSize: FontSize(14),
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).colorScheme.textSecondary,
                                    fontFamily: 'MontserratAlternates',
                                    margin: Margins.only(bottom: 0),
                                  ),
                                  ".acknowledgement": Style(
                                    // padding: HtmlPaddings.all(16),
                                    // fontWeight: FontWeight.w600,
                                    fontSize: FontSize(14),
                                    padding: HtmlPaddings.only(left: 0),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'MontserratAlternates',
                                    color: Theme.of(context).colorScheme.textSecondary,
                                    margin: Margins.only(bottom: 8),
                                  ),
                                },

                              )







                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckBox(
                                  height: 24,
                                  width: 24,
                                  onchanged: (value){
                                    _accept = value;
                                  }
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Terms and Conditions ',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.textPrimary
                                      ),
                                    ),
                                    SizedBox(height: 2.h,),
                                    Text(
                                      'I have read and understand their terms of condition',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.textSecondary
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h,),
                          CustomButton(
                              buttonText: 'Complete Onboarding',
                              onPressed: () async{
                                if(!_accept ){
                                  showFlushBar(
                                      context: context,
                                      message: 'Kindly accept the terms to complete your onboarding',
                                    success: false
                                  );
                                  return;
                                }

                                await registrationVm.completeOnboarding();
                                if(registrationVm.secondState == ViewState.retrieved){

                                  pushAndClearNavigation(context: context, widget: OnboardingSuccessful(
                                    agentId: registrationVm.onboardingCompletion?.uniqueID ?? '',
                                    isTemporaryOnboarding: false,
                                  ), routeName: NamedRoutes.onboardingSuccessful,
                                      clearRoute: NamedRoutes.login
                                  );

                                }

                                showFlushBar(
                                    context: context,
                                    message: registrationVm.message,
                                  success: registrationVm.secondState == ViewState.retrieved
                                );



                              }
                          )
                        ],
                      )
                    ],
                  );
                }

                if(vm.state == ViewState.error){
                  return Center(
                    child: ErrorState(
                      message: vm.message,
                        onPressed: ()=>vm.fetchTerms()),
                  );
                }

                return const SizedBox.shrink();

              }
            ),
          ),
        ),
      ),
    );
  }
}
