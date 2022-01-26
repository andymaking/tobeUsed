
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/domain/viewmodel/request_viewmodel.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

final userRequestProvider =
ChangeNotifierProvider.autoDispose<RequestViewModel>((ref) {
  ref.onDispose(() {});
  final viewmodel = locator.get<RequestViewModel>();
  //Load all setup questions here
  viewmodel.getUser();
  viewmodel.getAgents();
  viewmodel.walletBalance();
  viewmodel.getRequest();
  viewmodel.getPaymentProcessor();
  viewmodel.validateWithdrawDhoro("1000000000000", "USD");
  return viewmodel;
});

final _requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(userRequestProvider).viewState;
});
final requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_requestStateProvider);
});

class SetupPagerContainer extends StatefulHookWidget {
  SetupPagerContainer();

  @override
  _SetupPagerContainerState createState() => _SetupPagerContainerState();
}

class _SetupPagerContainerState extends State<SetupPagerContainer> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    context.read(userRequestProvider).disposeSellDhoroControllers();
    super.initState();
  }

  void navigate() {
    setState(() {
      final currentPage = useProvider(userRequestProvider).currentPage;
      if(currentPage > 0) {
        _controller.jumpToPage(currentPage - 1);
      } else {
        Navigator.of(context).pop();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);
    final currentPage = useProvider(userRequestProvider).currentPage;
    final totalPages = context.read(userRequestProvider).pages.length - 1;
    final progress =
    (currentPage / totalPages == 0) ? 0.05 : currentPage / totalPages;

    final pageview = PageView(
        controller: context.read(userRequestProvider).controller,
        onPageChanged: (position) {
          context.read(userRequestProvider).pageChanged(position);
        },
        physics: new NeverScrollableScrollPhysics(),
        children: context.read(userRequestProvider).widgetPages);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              pageview,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  AppFontsStyle.getAppTextViewBold("Sell Dhoro",
                      weight: FontWeight.w700,
                      size: AppFontsStyle.textFontSize16),
                  SizedBox(
                    height: 24,
                  ),
                  WithdrawProgressBar(),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read(userRequestProvider).disposeSellDhoroControllers();
    super.dispose();
  }

  showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        builder: (ctx) => Container(
          height: 425,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 8,
              ),
              SvgPicture.asset("assets/images/top_indicator.svg"),
              SizedBox(
                height: 24,
              ),
              AppFontsStyle.getAppTextViewBold("Withdraw Dhoro",
                  color: Pallet.colorRed,
                  weight: FontWeight.w700,
                  size: AppFontsStyle.textFontSize16),
              SizedBox(
                height: 24,
              ),
              WithdrawProgressBar(),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 40,
              ),

            ],
          ),
        ));
  }
}

