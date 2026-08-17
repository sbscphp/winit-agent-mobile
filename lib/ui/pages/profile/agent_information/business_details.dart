import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/lga_details_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/service_agents_vm.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/input_formatters/nigerian_rc_number_formatter.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/alert_dialogs/action_completed.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_check_box.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/text_fields/multi_select_dropdown.dart';
import '../../../widgets/text_fields/onboarding_drop_down.dart';
import '../../../widgets/text_fields/onboarding_text_field.dart';
import '../../onboarding/add_bank_details.dart';

class BusinessDetails extends ConsumerStatefulWidget {
  final bool fromOnboarding;
  const BusinessDetails({super.key, this.fromOnboarding = true});

  @override
  ConsumerState<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends ConsumerState<BusinessDetails> {

  final _formKey = GlobalKey<FormState>();
  final _tin = TextEditingController();
  final _rc = TextEditingController();
  final _phone1 = TextEditingController();
  final _phone2 = TextEditingController();
  final _email1 = TextEditingController();
  final _email2 = TextEditingController();
  final _address = TextEditingController();
  final _landmark = TextEditingController();
  final _otherAgents = TextEditingController();

  String? _selectedLga;
  bool _sameAsPersonalInfo = false;
  List<String> _posAgents = [];
  List<String> _lotteryAgents = [];


  @override
  void initState() {

    if(!widget.fromOnboarding){
      _initTextControllers(ref.read(profileViewModel));
    }

    super.initState();
  }

  _setAsPersonalInfo(ProfileVm vm){
    _phone1.text = vm.phone;
    _phone2.text = vm.phone2;
    _email1.text = vm.email;
    _email2.text = vm.email2;
    _address.text = vm.address;
    _landmark.text = vm.landmark;
    _selectedLga = vm.lga;
  }

  _clearTextControllers(){
    _phone1.clear();
    _phone2.clear();
    _email1.clear();
    _email2.clear();
    _address.clear();
    _landmark.clear();
    _selectedLga = null;
  }

  _initTextControllers(ProfileVm vm){
    _tin.text = vm.tinNumber;
    _rc.text = vm.rcNumber;
    _phone1.text = vm.bizPhone;
    _phone2.text = vm.bizPhone2;
    _email1.text = vm.bizEmail;
    _email2.text = vm.bizEmail2;
    _address.text = vm.bizAddress;
    _landmark.text = vm.bizLandmark;
    _selectedLga = vm.bizLga;
    _posAgents = List.from(vm.selectedPosAgents);
    _lotteryAgents = List.from(vm.selectedFinancialAgents);
    if(vm.otherAgents.isNotEmpty){
      _otherAgents.text = vm.otherAgents[0];
    }
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
          title: 'Business Details',
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
                        ScreenTitle(title: 'Business Details',
                            subtitle: 'Add business details to your WinIt Agent account setup.'
                        ),
                        if(widget.fromOnboarding)Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomCheckBox(
                                  height: 24,
                                  width: 24,
                                  color: ColorPath.mischkaGrey,
                                  onchanged: (value){
                                    setState(() {
                                      _sameAsPersonalInfo = value;

                                      if(_sameAsPersonalInfo){
                                        _setAsPersonalInfo(vm);
                                      }else{
                                        _clearTextControllers();
                                      }

                                    });

                                  }
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text(
                                  'Personal Details is the same as Business Details',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textTertiary
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Tax Identification Number',
                          hintText: 'Enter Tax Identification Number',
                          controller: _tin,
                          validator: (value) => FieldValidator.validateLength(value, requiredLength: 10, errorMessage: 'Tin Number must be 10 digits.'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'RC Number',
                          hintText: 'Enter RC Number',
                          isCompulsory: false,
                          controller: _rc,
                          //validator: FieldValidator.validate,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            NigerianRCNumberFormatter(),
                          ],
                          onChanged: (value){
                            print(value);
                          },
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Business Phone Number',
                          hintText: 'Enter Phone Number',
                          isCompulsory: false,
                          controller: _phone1,
                          //validator: FieldValidator.validate,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                            NigerianPhoneNumberFormatter()
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Business Phone Number 2',
                          hintText: 'Enter Phone Number',
                          isCompulsory: false,
                          controller: _phone2,
                          //validator: FieldValidator.validate,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                            NigerianPhoneNumberFormatter()
                          ],
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Business Email address 1',
                          hintText: 'Enter email',
                          controller: _email1,
                          validator: EmailValidator.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Business Email address 2 (optional)',
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
                          bottomHintText: 'We currently operate only within Lagos State. ',
                        ),
                        SizedBox(height: 16.h,),
                        OnboardingTextField(
                          label: 'Business Address',
                          hintText: 'Enter Business Address',
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
                        SizedBox(height: 16.h,),
                        currentBusiness(),
                        SizedBox(height: 42.h,),
                        CustomButton(
                            buttonText: widget.fromOnboarding ? 'Continue':'Save Changes',
                            onPressed: ()async{

                              final validate = _formKey.currentState!.validate();
                              if(validate){
                                Utilities.hideKeyboard(context);
                                await vm.updateBusinessInfo(
                                    bizEmail1: _email1.text,
                                    bizEmail2: _email2.text,
                                    bizPhone1: _phone1.text,
                                    bizPhone2: _phone2.text,
                                    lga: _selectedLga,
                                    bizAddress: _address.text,
                                    bizLandmark: _landmark.text,
                                    tinNumber: _tin.text,
                                    rcNumber: _rc.text,
                                    otherAgents: _otherAgents.text,
                                    posAgents: _posAgents,
                                    lotteryAgents: _lotteryAgents
                                );

                                if(vm.state == ViewState.retrieved){

                                  if(widget.fromOnboarding){
                                    pushAndClearNavigation(context: context, widget: const AddBankDetails(), routeName: NamedRoutes.addBankDetails, clearRoute: NamedRoutes.login,);
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
                                          popUntilNavigation(context: context, route: NamedRoutes.agentInformation);
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

  currentBusiness(){
    final serviceAgentsVm = ref.read(serviceAgentsViewModel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenTitle(
            title: 'Current Business',
            titleColor: ColorPath.oxfordBlue,
            titleFontWeight: FontWeight.w700,
            subtitle: 'Please select the type(s) of business you currently operate'
        ),
        SizedBox(height: 16.h,),
        ScreenTitle(
            title: 'Financial Agent',
            titleFontWeight: FontWeight.w600,
            subtitle: 'I currently operate POS as a business'
        ),
        SizedBox(height: 16.h,),
        MultiSelectDropdown(
          label: 'Bank(s)/ FinTech(s)',
          hintText: 'Select all the Bank(s)/FinTech(s) you currently work with',
          dropdownTitle: 'POS Principal',
          dropdownSubtitle: 'A list of POS Companies',
          options: serviceAgentsVm.posAgentsNames,
          initialValues: _posAgents,
          selectedItemsReturned: (value){
            print('returned items::::$value>>>>>');
            _posAgents = value;
          },

        ),
        CustomDivider(
          verticalSpace: 16.h,
        ),
        ScreenTitle(
            title: 'Lottery',
            titleFontWeight: FontWeight.w600,
            subtitle: 'I currently work as an agent for a lottery company'
        ),
        SizedBox(height: 16.h,),
        MultiSelectDropdown(
          label: 'Lottery Company',
          hintText: 'Select all the lottery companies you currently work with',
          dropdownTitle: 'Lottery Agent',
          dropdownSubtitle: 'A list of lottery Companies',
          options:serviceAgentsVm.financialAgentsNames,
          initialValues: _lotteryAgents,
          selectedItemsReturned: (value){
            print('returned items::::$value>>>>>');
            _lotteryAgents = value;
          },

        ),
        CustomDivider(
          verticalSpace: 16.h,
        ),
        ScreenTitle(
            title: 'Others',
            titleFontWeight: FontWeight.w600,
            subtitle: 'Please specify your current business'
        ),
        SizedBox(height: 16.h,),
        OnboardingTextField(
          label: 'Business type',
          hintText: 'Enter Details',
          isCompulsory: false,
          controller: _otherAgents,
          keyboardType: TextInputType.text,
          //validator: FieldValidator.validate,
          bottomHintText: 'e.g., retail, catering, beauty salon',
        ),
      ],
    );
  }
  }
