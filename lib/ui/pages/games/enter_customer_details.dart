import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/view_models/authentication/otp_vm.dart';
import 'package:winit_agent/core/data/view_models/games/customer_details_vm.dart';
import 'package:winit_agent/core/data/view_models/games/selected_game_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/core/utilities/validator.dart';
import 'package:winit_agent/ui/pages/games/select_payment_method.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/alert_dialogs/otp_dialog.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/games/game_appbar_title.dart';
import '../../widgets/games/game_purchase_dock.dart';
import '../../widgets/games/game_purchase_header.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/text_fields/onboarding_text_field.dart';
import '../../widgets/winit_container.dart';

class EnterCustomerDetails extends ConsumerStatefulWidget {
  const EnterCustomerDetails({super.key});

  @override
  ConsumerState<EnterCustomerDetails> createState() => _EnterCustomerDetailsState();
}

class _EnterCustomerDetailsState extends ConsumerState<EnterCustomerDetails> with TickerProviderStateMixin{

  late TabController _controller;

  bool _is18 = false;

  //new customer
  final _formKey = GlobalKey<FormState>();
  final _dob = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _confirmEmail = TextEditingController();

  //returning customer
  final _formKey2 = GlobalKey<FormState>();
  final _search = TextEditingController();



  @override
  void initState() {
    //init tab controller
    _controller = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(selectedGameViewModel);
    final otpVm = ref.watch(otpViewModel);
    final customerDetailsVm = ref.watch(customerDetailsViewModel);
    return BusyOverlay(
      show: otpVm.state == ViewState.busy || customerDetailsVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          centerTitle: false,
          useCustomTitleWidget: true,
          titleWidget: GameAppbarTitle(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: AppDimension.paddingLeft,
                        right: AppDimension.paddingRight,
                        top:AppDimension.paddingTop,
                        bottom: 16.h
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GamePurchaseHeader(
                            title: 'Enter Customer Details',
                            subtitle: 'Enter only valid customer information',
                            stepValue: 2,
                          ),
                          SizedBox(height: 16.h,),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.w
                            ),
                            decoration: BoxDecoration(
                              color: ColorPath.titanPurple,
                              borderRadius: BorderRadius.all(Radius.circular(12.r))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      NairaDisplay(
                                        amount: vm.amount,
                                        addDecimal: false,
                                        fontSize: 14.sp,
                                        color:ColorPath.blueBlue,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      SizedBox(height: 2.h,),
                                      Text(
                                        '${Utilities.formatAmount(
                                          amount: vm.quantity.toDouble(),
                                          addDecimal: false
                                        )} ${vm.quantity > 1 ? 'Tickets':'Ticket'}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textPrimary
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                Clickable(
                                  onPressed: (){
                                    popNavigation(context: context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                      horizontal: 16.w
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorPath.pigPink,
                                      borderRadius: BorderRadius.all(Radius.circular(10000.r))
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Edit Purchase',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ColorPath.ribbonRed
                                          ),
                                        ),
                                        SizedBox(width: 8.w,),
                                        CustomAssetViewer(asset: AppAsset.edit, height: 16.h, width: 16.w,)

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      tabBar(),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _controller,
                children: [
                  newCustomer(),
                  returningCustomer(customerDetailsVm),
                ],
              ),
            ),
          ),
            SizedBox(height: 20.h,),
            GamePurchaseDock(
                onPressed: ()async{

                  if(_controller.index == 0){

                    //new customer
                    final validate = _formKey.currentState!.validate();
                    if(validate){
                      if(_dob.text.isEmpty){
                        showFlushBar(
                            context: context,
                            message: 'Kindly enter your date of birth to proceed',
                          success: false
                        );
                        return;
                      }
                      if(!_is18){
                        showFlushBar(
                            context: context,
                            message: 'Kindly ensure and confirm that customer is 18 years of age and over',
                          success: false
                        );
                        return;
                      }
                      if(_email.text.trim() != _confirmEmail.text.trim()){
                        showFlushBar(
                            context: context,
                            message: "Your emails don't match",
                            success: false
                        );
                        return;
                      }

                      final cleanedPhone = Utilities.cleanPhoneNumber(phoneNumber: _phone.text);

                      await otpVm.sendOtp(
                          otpType: OtpType.createCustomer,
                          payload: {
                            "phone_number": cleanedPhone
                          },
                      );

                      if(otpVm.state == ViewState.retrieved){


                        if(otpVm.isReturningUser){
                          //init text controller for search field
                          _search.text = otpVm.returningUserPhone;
                          //move to 2nd tab
                          _controller.animateTo(1);

                          showFlushBar(
                              context: context,
                              message: otpVm.message,
                              success: false
                          );

                          return;
                        }

                        controllableBaseDialog(
                          context: context,
                          onClosed: () {
                          },
                          builder: (context, setDismissible) {
                            return OtpDialog(
                              title: 'Enter OTP from Customer to Validate and Purchase Ticket',
                              subtitle: 'We sent a 6 digit OTP to customer phone Number ${Utilities.maskCharacters(
                                subject: Utilities.formatSavedUserPhoneNumber(phoneNumber: cleanedPhone),
                                startIndex: 4,
                              )}, associated with WinIT. Kindly enter your OTP Below. ',
                              identifier: cleanedPhone,
                              otpType: OtpType.createCustomer,
                              onDone: (value)async{
                                if(value){

                                  //create customer
                                  await customerDetailsVm.createCustomer(
                                      firstname: _firstname.text,
                                      lastname: _lastname.text,
                                      dob: _dob.text,
                                      phone: cleanedPhone,
                                      email: _email.text
                                  );

                                  if(customerDetailsVm.state == ViewState.retrieved){
                                    pushNavigation(context: context, widget: const SelectPaymentMethod(), routeName: NamedRoutes.selectPaymentMethod);
                                  }

                                  showFlushBar(
                                      context: context,
                                      message: customerDetailsVm.message,
                                      success: customerDetailsVm.state == ViewState.retrieved
                                  );

                                }
                              },
                              onLoading: (loading) {
                                setDismissible(!loading);
                              },
                            );

                          },
                        );
                      }else{
                        showFlushBar(
                            context: context,
                            message: otpVm.message,
                          success: false
                        );
                      }






                    }
                  }
                  else{
                    //returning customer

                    //check if a customer has been selected
                    if(customerDetailsVm.selectedCustomer == null){
                      showFlushBar(
                          context: context,
                          message: 'Kindly search and select a customer to proceed',
                        success: false
                      );
                      return;
                    }

                    pushNavigation(context: context, widget: const SelectPaymentMethod(), routeName: NamedRoutes.selectPaymentMethod);

                  }
                }
            )
          ],
        ),
      ),
    );
  }

  tabBar() => TabBar(
    controller: _controller,
    isScrollable: false,
    labelPadding: EdgeInsets.zero,
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: ColorPath.curiousBlue,
    indicatorColor: ColorPath.curiousBlue,
    dividerColor: Colors.transparent,
    unselectedLabelColor: ColorPath.santasGrey,
    unselectedLabelStyle: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    labelStyle: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    tabs: [
      Tab(child: FittedBox(child: Text('New Customer'))),
      Tab(child: FittedBox(child: const Text('Returning Customer'))),
    ],
  );

  newCustomer(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: AppDimension.paddingLeft
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingTextField(
                label: 'First Name',
                hintText: 'Enter First Name',
                controller: _firstname,
                validator: FieldValidator.validate,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 24.h,),
              OnboardingTextField(
                label: 'Last Name',
                hintText: 'Enter Last Name',
                controller: _lastname,
                validator: FieldValidator.validate,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 24.h,),
              Clickable(
                onPressed: (){
                  baseBottomSheet(
                      context: context,
                      content: BirthdaySelectorView(
                          initialDate: DateFormat("dd-MM-yyyy").tryParse(_dob.text),
                          returningValue: (value){
                            setState(() {
                              //set birthdate text controller
                              _dob.text = value;
                            });
                          })
                  );
                },
                child: OnboardingTextField(
                  enabled: false,
                  label: 'Date of Birth',
                  hintText: 'DD/MM/YYYY',
                  controller: _dob,
                  //validator: EmailValidator.validateEmail,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 24.h,),
              OnboardingTextField(
                label: 'Phone Number',
                hintText: 'Enter Phone Number',
                controller: _phone,
                validator: FieldValidator.validate,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(18),
                  NigerianPhoneNumberFormatter()
                ],
              ),
              SizedBox(height: 24.h,),
              OnboardingTextField(
                label: 'Email Address',
                hintText: 'Enter email',
                controller: _email,
                isCompulsory: false,
                //validator: EmailValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h,),
              OnboardingTextField(
                label: 'Confirm Email Address ',
                hintText: 'confirm email',
                controller: _confirmEmail,
                isCompulsory: false,
                //validator: (value) => FieldValidator.compareAndConfirm(value, source: _email.text, errorMessage: 'Your emails don’t match.'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      height: 24,
                      width: 24,
                      onchanged: (value){
                        _is18 = value;
                      }
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer is 18 and Over',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.textPrimary
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Text(
                          'Customer verifies and validates that they are 18 years of age and over',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.textSecondary
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }

  returningCustomer(CustomerDetailsVm vm){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: AppDimension.paddingLeft
      ),
      child: SafeArea(
        child: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingTextField(
                label: 'Customer ID/Phone Number',
                hintText: 'Enter Customer ID/Phone Number',
                controller: _search,
                validator: FieldValidator.validate,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(18),
                  NigerianPhoneNumberFormatter()
                ],
              ),
              SizedBox(height: 16.h,),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  buttonWidth: null,
                    buttonText: 'Search Customer',
                    onPressed: () async{
                      final validate = _formKey2.currentState!.validate();
                      if(validate){
                        await vm.searchCustomer(phone: _search.text);
                        showFlushBar(
                            context: context,
                            message: vm.message,
                          success: vm.state == ViewState.retrieved
                        );
                      }
                    }
                ),
              ),
              if(vm.customers.isNotEmpty) SizedBox(height: 24.h,),
              if(vm.customers.isNotEmpty)Text(
                vm.customers.length > 1 ? 'Customers Found':'Customer Found',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              if(vm.customers.isNotEmpty) SizedBox(height: 16.h,),
              if(vm.customers.isNotEmpty)ListView.separated(
                itemCount: vm.customers.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  final customer = vm.customers[index];
                  final phone = customer.phoneNumber ?? 'N/A';
                  final firstname = customer.firstname ?? 'N/A';
                  final lastname = customer.lastname ?? 'N/A';
                  final isSelected = customer.uuid == vm.selectedCustomer?.uuid;
                  return Clickable(
                    onPressed: (){
                      vm.selectedCustomer = customer;
                    },
                    child: WinitContainer(
                      bgColor: ColorPath.magnoliaPurple,
                      border: Border.all(color: ColorPath.meirosePurple, width: 1.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRadioButton(disableClick: true, value: isSelected,),
                                SizedBox(width: 8.w,),
                                Container(
                                    height: 32.h,
                                    width: 32.w,
                                    decoration: BoxDecoration(
                                        color: ColorPath.periwinklePurple,
                                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                                    ),
                                    child: Center(child: CustomAssetViewer(asset: AppAsset.avatar3, height: 16.h, width: 16.w,))),
                                SizedBox(width: 8.w,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        phone,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).colorScheme.textPrimary
                                        ),
                                      ),
                                      SizedBox(height: 2.h,),
                                      FittedBox(
                                        child: Text(
                                          '$firstname $lastname',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context).colorScheme.textSecondary
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h,);
                },
              )







            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) =>
      oldDelegate.tabBar != tabBar;
}
