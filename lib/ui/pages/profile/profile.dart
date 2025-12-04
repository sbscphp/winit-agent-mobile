import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/authentication/logout_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/account_closure_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/transaction_pin_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/authentication/login.dart';
import 'package:winit_agent/ui/pages/profile/account_closure/account_closure.dart';
import 'package:winit_agent/ui/pages/profile/agent_information/agent_information.dart';
import 'package:winit_agent/ui/pages/profile/manage_bank_accounts/manage_bank_accounts.dart';
import 'package:winit_agent/ui/pages/profile/referral_management/referral_management.dart';
import 'package:winit_agent/ui/pages/profile/transaction_pin/transaction_pin.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/profile/profile_option.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/alert_dialogs/action_confirmation.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/alert_dialogs/enter_transaction_pin.dart';
import '../../widgets/cross_fade_widget.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/profile/profile_image.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {

  final switchNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final logoutVm = ref.watch(logoutViewModel);
    final accountClosureVm = ref.watch(accountClosureViewModel);
    return BusyOverlay(
      show: logoutVm.state == ViewState.busy || accountClosureVm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          centerTitle: true,
          leadingIcon: ProfileImage(),
          title: 'My Profile',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: AppDimension.paddingLeft,
              right: AppDimension.paddingRight,
              top: 32.h,
            bottom: 50.h
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileOption(
                  asset:AppAsset.avatar3,
                  label:'Personal Information',
                 subtitle: 'Setup and Update your personal details',
                  onPressed: (){
                    pushNavigation(context: context, widget: const AgentInformation(), routeName: NamedRoutes.agentInformation);
                  }
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.bankDetails,
                  label:'Bank Account Details',
                  subtitle: 'Manage Account number for withdrawal',
                  onPressed: (){
                    pushNavigation(context: context, widget: const ManageBankAccounts(), routeName: NamedRoutes.manageBankAccounts);
                  }
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.pin,
                  label:'Transaction Pin',
                  subtitle: 'Setup transaction PIN for your Account',
                  onPressed: (){
                    pushNavigation(context: context, widget: const TransactionPin(), routeName: NamedRoutes.transactionPin);
                  }
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.faq,
                  label:'FAQ',
                  subtitle: 'FAQs on winIt Agent App',
                  onPressed: (){}
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.support,
                  label:'Support',
                  subtitle: 'Contact support to help solve issue with system use.',
                  onPressed: (){}
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.support,
                  label:'Referral Management',
                  subtitle: 'Refer other agent and Earn with ease today.',
                  onPressed: (){
                    pushNavigation(context: context, widget: const ReferralManagement(), routeName: NamedRoutes.referralManagement);
                  }
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.legal,
                  label:'Legal',
                  subtitle: 'Privacy Policy, Terms of Use, Cookies etc. ',
                  onPressed: (){
                  }
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.logout,
                  label:'Logout',
                  subtitle: 'Log out of your winIt Agent account',
                  onPressed: (){
                    baseDialog(
                      context: context,
                      content: ActionConfirmation(
                        title: 'Logout ?',
                        subtitle:
                        'Are you sure you want to logout?',
                        buttonText: 'Yes, Logout',
                        onPressed: ()async{
                          await logoutVm.logout();

                          if(logoutVm.state == ViewState.retrieved){
                            pushAndClearNavigation(context: context, widget: const Login(),
                            routeName: NamedRoutes.login,
                              clearRoute: NamedRoutes.landing
                            );
                          }

                          showFlushBar(
                              context: context,
                              message: logoutVm.message,
                            success: logoutVm.state == ViewState.retrieved
                          );

                        },
                      ),
                    );
                  }
              ),
              SizedBox(height: 24.h,),
              ProfileOption(
                  asset:AppAsset.logout,
                  label:'Account Closure',
                  subtitle: 'Initiate the process to close your account',
                  onPressed: (){
                    pushNavigation(context: context, widget: const AccountClosure(), routeName: NamedRoutes.accountClosure);
                  }
              ),
              SizedBox(height: 24.h,),
              Clickable(
                onPressed: (){
                  controllableBaseDialog(
                    context: context,
                    onClosed: () {
                      switchNotifier.value = false;
                    },
                    builder: (context, setDismissible) {
                      return CrossFadeWidget(
                          switchNotifier: switchNotifier,
                          firstChild: ActionConfirmation(
                            popInternally: false,
                            title: 'Delete Account?',
                            subtitle:
                            'Are you sure you want to delete your account?',
                            buttonText: 'Yes, Delete',
                            onPressed: () => switchNotifier.value = true,
                          ),
                          secondChild: EnterTransactionPin(
                            visitingRoute: NamedRoutes.bottomNav,
                            buttonText: 'Delete Account',
                            onDone: (success) async{
                              // setDismissible(true);

                              await accountClosureVm.deleteAccount(
                                  pin: ref.read(transactionPinViewModel).currentPin ?? ''
                              );

                              if(accountClosureVm.secondState == ViewState.retrieved){
                                pushAndClearNavigation(context: context, widget: const Login(),
                                    routeName: NamedRoutes.login,
                                    clearRoute: NamedRoutes.landing
                                );
                              }

                              showFlushBar(
                                  context: context,
                                  message: accountClosureVm.message,
                                  success: accountClosureVm.secondState == ViewState.retrieved,
                              );
                            },
                            onLoading: (loading) {
                              setDismissible(!loading);
                            },
                          )
                      );

                    },
                  );
                },
                child: CustomPaint(
                  painter: DottedBorder(
                      color: ColorPath.ribbonRed,
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  child: WinitContainer(
                    bgColor: ColorPath.remyPink,
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Delete my Account',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorPath.ribbonRed
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          CustomAssetViewer(asset: AppAsset.delete2)
                        ],
                      )
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


}
