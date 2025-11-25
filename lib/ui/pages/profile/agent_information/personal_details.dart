import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/lga_details_vm.dart';
import 'package:winit_agent/ui/pages/profile/agent_information/business_details.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/alert_dialogs/action_completed.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/display_image.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/text_fields/onboarding_drop_down.dart';
import '../../../widgets/text_fields/onboarding_text_field.dart';

class PersonalDetails extends ConsumerStatefulWidget {
  final bool isFromOnboarding;
  const PersonalDetails({super.key, this.isFromOnboarding = true});

  @override
  ConsumerState<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends ConsumerState<PersonalDetails> {

  final _formKey = GlobalKey<FormState>();
  final _phone1 = TextEditingController();
  final _phone2 = TextEditingController();
  final _email1 = TextEditingController();
  final _email2 = TextEditingController();
  final _address = TextEditingController();
  final _landmark = TextEditingController();

  String? _selectedLga;

  @override
  void initState() {
    final vm = ref.read(profileViewModel);
    print('phone from vm::::${vm.phone}>>>');
    _phone1.text = vm.phone;
    _email1.text = vm.email;
    if(!widget.isFromOnboarding){
      _email2.text = vm.email2;
      _phone2.text = vm.phone2;
      _address.text = vm.address;
      _landmark.text = vm.landmark;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(profileViewModel);
    final lgaDetailsVm = ref.watch(lgaDetailsViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Personal Details',
        ),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              if(lgaDetailsVm.state == ViewState.busy){
                return Center(
                  child: AppLoader(),
                );
              }

              if(lgaDetailsVm.state == ViewState.retrieved){
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenTitle(title: widget.isFromOnboarding ? 'Add more Personal Details':'Personal Details',
                            subtitle: 'Add more details to your WinIt Agent account setup. '
                        ),
                        if(!widget.isFromOnboarding)WinitContainer(
                            margin: EdgeInsets.only(top: 24.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 16.w
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    DisplayImage(
                                      addOverlay: true,
                                      imageUrl: vm.avatar,
                                      firstName: vm.firstname,
                                      lastName: vm.lastname,
                                      initialsSize: 16,
                                      size: 43,
                                    ),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        top: 0,
                                        child: Center(child: CustomAssetViewer(asset: AppAsset.edit2, height: 16.h, width: 16.w,)))
                                  ],
                                ),
                                SizedBox(width: 8.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dairo Agent LLC',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).colorScheme.textSecondary
                                        ),
                                      ),
                                      SizedBox(height: 4.h,),
                                      Text(
                                        'KSF - 002390',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textTertiary
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        SizedBox(height: 24.h,),
                        OnboardingTextField(
                          label: 'Account linked Phone Number',
                          hintText: 'Enter Account linked Phone Number',
                          controller: _phone1,
                          validator: FieldValidator.validate,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                            NigerianPhoneNumberFormatter()
                          ],
                          bottomHintText: 'You cannot change your temporary Agent ID until you complete the full self-onboarding process',
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Phone Number 2 (optional)',
                          hintText: 'Enter Phone Number',
                          isCompulsory: false,
                          controller: _phone2,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                            NigerianPhoneNumberFormatter()
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Email address 1',
                          hintText: 'Enter email',
                          controller: _email1,
                          enabled: false,
                          validator: EmailValidator.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Email address 2 (optional)',
                          hintText: 'Enter email',
                          isCompulsory: false,
                          controller: _email2,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingDropDown(
                          hintText: "Select an option",
                          label: 'Local Government (Lagos State) of residence',
                          value: _selectedLga,
                          items: lgaDetailsVm.lgaNames,
                          onChanged: (value){
                            _selectedLga = value;
                          },
                          bottomHintText: 'We currently operate only within Lagos State. ',
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Full House Address',
                          hintText: 'Enter House Address',
                          controller: _address,
                          keyboardType: TextInputType.text,
                          validator: FieldValidator.validate,
                          bottomHintText: 'This should be inclusive of your house number, street name and other relevant details',
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Closest Landmark/Nearest Bus-stop',
                          hintText: 'Enter Details',
                          controller: _landmark,
                          keyboardType: TextInputType.text,
                          validator: FieldValidator.validate,
                          bottomHintText: 'A well-known location near your address (e.g., shopping mall, petrol station, school, or bus stop). This helps us easily identify and confirm your location.',
                        ),
                        SizedBox(height: 42.h,),
                        CustomButton(
                            buttonText: widget.isFromOnboarding ? 'Continue':'Save Changes',
                            onPressed: ()async{
                              Utilities.hideKeyboard(context);
                              final validate = _formKey.currentState!.validate();
                              if(validate){

                               await vm.updatePersonalInfo(
                                   otherEmail: _email2.text,
                                   otherPhone: _phone2.text,
                                   lga: _selectedLga,
                                   address: _address.text,
                                   landmark: _landmark.text
                               );

                               if(vm.state == ViewState.retrieved){

                                 if(widget.isFromOnboarding){
                                   pushAndClearNavigation(context: context, widget: const BusinessDetails(), routeName: NamedRoutes.businessDetails, clearRoute: NamedRoutes.login,);
                                   showFlushBar(
                                       context: context,
                                       message: vm.message,
                                   );
                                 }
                                 else{
                                   baseDialog(
                                     context: context,
                                     content: ActionCompleted(
                                       title: 'Changes Saved',
                                       assetSize: 80,
                                       subtitle:
                                       'New Changes Saved and Updated',
                                       onPressed: () {
                                         popNavigation(context: context);
                                       },
                                     ),
                                   );
                                 }

                               }else{
                                 showFlushBar(
                                     context: context,
                                     message: vm.message,
                                   success: false
                                 );
                               }

                              }
                            }
                        ),


                      ],
                    ),
                  ),
                );
              }

              if(lgaDetailsVm.state == ViewState.error){
                return Center(
                  child: ErrorState(
                    message: lgaDetailsVm.message,
                      onPressed: ()=>lgaDetailsVm.fetchLgaDetails()),
                );
              }

              return const SizedBox.shrink();

            }
          ),
        ),
      ),
    );
  }
}
