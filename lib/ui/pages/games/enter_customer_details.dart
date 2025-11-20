import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/core/utilities/validator.dart';
import 'package:winit_agent/ui/pages/games/select_payment_method.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/games/game_purchase_dock.dart';
import '../../widgets/games/game_purchase_header.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/text_fields/onboarding_text_field.dart';
import '../../widgets/winit_container.dart';

class EnterCustomerDetails extends StatefulWidget {
  const EnterCustomerDetails({super.key});

  @override
  State<EnterCustomerDetails> createState() => _EnterCustomerDetailsState();
}

class _EnterCustomerDetailsState extends State<EnterCustomerDetails> with TickerProviderStateMixin{

  late TabController _controller;

  final _dob = TextEditingController();

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //   child: SingleChildScrollView(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: AppDimension.paddingLeft,
          //         vertical: 14.h
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //       ],
          //     ),
          //   ),
          // ),
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
                                      amount: 5000,
                                      addDecimal: false,
                                      fontSize: 14.sp,
                                      color:ColorPath.blueBlue,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    SizedBox(height: 2.h,),
                                    Text(
                                      '10 Tickets',
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
                returningCustomer(),
              ],
            ),
          ),
        ),
          SizedBox(height: 20.h,),
          GamePurchaseDock(
              onPressed: (){
                pushNavigation(context: context, widget: const SelectPaymentMethod(), routeName: NamedRoutes.selectPaymentMethod);
              }
          )
        ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnboardingTextField(
              label: 'First Name',
              hintText: 'Enter First Name',
              //controller: _loginChoice,
              validator: FieldValidator.validate,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 24.h,),
            OnboardingTextField(
              label: 'Last Name',
              hintText: 'Enter Last Name',
              //controller: _loginChoice,
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
                //controller: _loginChoice,
                //validator: EmailValidator.validateEmail,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 24.h,),
            OnboardingTextField(
              label: 'Phone Number',
              hintText: 'Enter Phone Number',
              //controller: _loginChoice,
              validator: FieldValidator.validate,
              enabled: false,
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
              //controller: _loginChoice,
              validator: EmailValidator.validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24.h,),
            OnboardingTextField(
              label: 'Confirm Email Address ',
              hintText: 'confirm email',
              //controller: _loginChoice,
              validator: EmailValidator.validateEmail,
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
    );
  }

  returningCustomer(){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: AppDimension.paddingLeft
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnboardingTextField(
              label: 'Customer ID/Phone Number',
              hintText: 'Enter Customer ID/Phone Number',
              //controller: _loginChoice,
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
                  onPressed: () {
                    //pushNavigation(context: context, widget: const BottomNav(), routeName: NamedRoutes.bottomNav);
                  }
              ),
            ),
            SizedBox(height: 24.h,),
            Text(
              'Customer Found ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 16.h,),
            WinitContainer(
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
                        CustomRadioButton(disableClick: true, value: true,),
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
                                '08028424699',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).colorScheme.textPrimary
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              FittedBox(
                                child: Text(
                                  'Salisu Funke Olajide',
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
            )






          ],
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
