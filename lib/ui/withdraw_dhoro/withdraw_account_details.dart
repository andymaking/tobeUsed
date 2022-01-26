import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/data/remote/model/validate/validate.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/withdraw_dhoro/withdraw_dhoro_pages_container.dart' as sharedProvider;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _agentStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(sharedProvider.userRequestProvider).viewState;
});
final agentStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_agentStateProvider);
});

class WithdrawAccountDetailsPage extends StatefulHookWidget {
  const WithdrawAccountDetailsPage({Key? key}) : super(key: key);

  @override
  _WithdrawAccountDetailsPageState createState() => _WithdrawAccountDetailsPageState();
}

class _WithdrawAccountDetailsPageState extends State<WithdrawAccountDetailsPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);

    List<AgentsData>? agents = useProvider(sharedProvider.userRequestProvider).agents;
    context.read(sharedProvider.userRequestProvider).agentId = "${agents.first.pk}";
    ValidateWithdrawResponse? validateWithdrawResponse = useProvider(sharedProvider.userRequestProvider).validateWithdrawResponse;

    ViewState viewState = useProvider(agentStateProvider);
    print("Showing agents length: ${agents.length}");

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Pallet.colorBlue;
      }
      return Pallet.colorBlue;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 200.0,
                          ),
                          agents.isNotEmpty == true
                              ? viewState == ViewState.Loading
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(agents.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = index;
                                          context.read(sharedProvider.userRequestProvider).buyAgentId = agents[index].pk!;
                                          context.read(sharedProvider.userRequestProvider).getSingleAgents("${agents[index].pk}");
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Pallet.colorBlue),
                                          borderRadius: BorderRadius.all(Radius.circular(2)),
                                        ),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: selected == index,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    context.read(sharedProvider.userRequestProvider).agentId = agents[index].pk!;
                                                    print("Show clicked INDEX... ${agents[index].pk}");
                                                  });
                                                }),
                                            AppFontsStyle.getAppTextViewBold(
                                                "${agents[index].accountName!.toTitleCase()!}",
                                                weight: FontWeight.w500,
                                                size:
                                                AppFontsStyle.textFontSize12),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 16.0),
                                              child: Container(
                                                child: AppFontsStyle.getAppTextViewBold(
                                                    "${agents[index].bankName!.toTitleCase()!}",
                                                    weight: FontWeight.w500,
                                                    color: Pallet.colorGrey,
                                                    size:
                                                    AppFontsStyle.textFontSize12),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            ),
                          )
                              :buildEmptyView(),

                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 24, right: 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read(sharedProvider.userRequestProvider).moveToPreviousPage();

                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Pallet.colorRed),
                              borderRadius:
                              BorderRadius.all(Radius.circular(2))),
                          child: Center(
                            child: AppFontsStyle.getAppTextViewBold(
                              "Cancel",
                              color: Pallet.colorRed,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          context
                              .read(sharedProvider.userRequestProvider).moveToNextPage();
                          setState(() {
                            //context.read(sharedProvider.userRequestProvider).getSingleAgents("${agents[selected].pk}");
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Pallet.colorBlue,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: AppFontsStyle.getAppTextViewBold(
                              "PROCEED",
                              color: Pallet.colorWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget buildEmptyView() {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          AppFontsStyle.getAppTextViewBold("No agents yet",
              size: 14, textAlign: TextAlign.center, color: Pallet.colorBlue),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
