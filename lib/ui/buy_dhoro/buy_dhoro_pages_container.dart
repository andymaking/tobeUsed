
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/domain/viewmodel/buy_viewmodel.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';

final userRequestProvider =
ChangeNotifierProvider.autoDispose<BuyViewModel>((ref) {
  ref.onDispose(() {});
  final viewmodel = locator.get<BuyViewModel>();
  //Load all setup questions here
  viewmodel.getRequest();
  viewmodel.getPaymentProcessor();
  return viewmodel;
});

final _requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(userRequestProvider).viewState;
});
final requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_requestStateProvider);
});

class BuySetupPagerContainer extends StatefulHookWidget {
  BuySetupPagerContainer();

  @override
  _BuySetupPagerContainerState createState() => _BuySetupPagerContainerState();
}

class _BuySetupPagerContainerState extends State<BuySetupPagerContainer> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
  }

  void navigate() {
    final currentPage = useProvider(userRequestProvider).currentPage;
    if(currentPage > 0) {
      _controller.jumpToPage(currentPage - 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  AppFontsStyle.getAppTextViewBold("Buy Dhoro",
                      weight: FontWeight.w700,
                      size: AppFontsStyle.textFontSize16),
                  SizedBox(
                    height: 24,
                  ),
                  BuyProgressBar(),
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
    context.read(userRequestProvider).controller.dispose();
    super.dispose();
  }

}

