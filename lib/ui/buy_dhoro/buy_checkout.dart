import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/agents/agent.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/buy_dhoro/buy_dhoro_pages_container.dart'
    as sharedProvider;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/viewmodel/request_viewmodel.dart';
import '../../main.dart';

final userBuyProvider =
ChangeNotifierProvider.autoDispose<RequestViewModel>((ref) {
  ref.onDispose(() {});
  final viewmodel = locator.get<RequestViewModel>();
  viewmodel.getAgents();
  return viewmodel;
});

final _agentStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(sharedProvider.userBuyProvider).viewState;
});
final agentStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_agentStateProvider);
});

final _agentsProvider =
Provider.autoDispose<List<AgentsData>>((ref) {
  return ref.watch(userBuyProvider).agents;
});
final agentsProvider =
Provider.autoDispose<List<AgentsData>>((ref) {
  return ref.watch(_agentsProvider);
});


class BuyCheckoutPage extends StatefulHookWidget {
  const BuyCheckoutPage({Key? key}) : super(key: key);

  @override
  _BuyCheckoutPageState createState() => _BuyCheckoutPageState();
}

class _BuyCheckoutPageState extends State<BuyCheckoutPage> {
  List<AgentsData> selectedAgents = [];
  int selected = 0;

  @override
  Widget build(BuildContext context) {

    List<AgentsData>? agents = useProvider(userBuyProvider).agents;
    Future.delayed(
        Duration(seconds: 1),
    () {
        context.read(userBuyProvider).buyAgentId = "${agents.first.pk ?? ""}";
    });


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

    return RefreshIndicator(
      color: Pallet.colorBlue,
      onRefresh: () {
        return Future.delayed(
            Duration(seconds: 1),
                () {
              setState(() {
                context.read(userBuyProvider).getAgents();
              });
            });
      },
      child: Scaffold(
        backgroundColor: Pallet.colorWhite,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Stack(
                children: [
                  RefreshIndicator(
                    color: Pallet.colorBlue,
                    onRefresh: () {
                      return Future.delayed(
                          Duration(seconds: 1),
                              () {
                            setState(() {
                              context.read(userBuyProvider).getAgents();
                            });
                          });
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 160.0,
                          ),
                          agents.isNotEmpty == true
                              ? viewState == ViewState.Loading
                              ? Center(child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: AppProgressBar(),
                          ))
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
                                          context.read(sharedProvider.userBuyProvider).buyAgentId = agents[index].pk.toString();
                                          //context.read(sharedProvider.userBuyProvider).getSingleAgents("${agents[index].pk}");
                                          print("Showing agent selected ID:: ${agents[index].pk.toString()}");
                                          print("Showing selected index:: $selected");
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
                                                    context.read(sharedProvider.userBuyProvider).buyAgentId = agents[index].pk.toString();

                                                    print("Show clicked INDEX... ${agents[index].pk}");
                                                  });
                                                }),
                                            AppFontsStyle.getAppTextViewBold(
                                                "${agents[index].accountName.toString().toTitleCase()!}",
                                                weight: FontWeight.w500,
                                                size:
                                                AppFontsStyle.textFontSize12),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 16.0),
                                              child: Container(
                                                child: AppFontsStyle.getAppTextViewBold(
                                                    "${agents[index].bankName.toString().toTitleCase()!}",
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
                              : Center(child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: AppProgressBar(),
                          )),
                          //buildEmptyView(),

                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read(sharedProvider.userBuyProvider).moveBuyToPreviousPage();
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
                                  .read(sharedProvider.userBuyProvider).moveBuyToNextPage();
                              setState(() {
                                print("Showing selected index:: $selected");
                                context.read(sharedProvider.userBuyProvider).getSingleAgents("${agents[selected].pk}");
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
                ],
              ),
            ),
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
