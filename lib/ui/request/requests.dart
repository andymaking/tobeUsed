
import 'package:dhoro_mobile/data/core/view_state.dart';
import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/domain/viewmodel/request_viewmodel.dart';
import 'package:dhoro_mobile/main.dart';
import 'package:dhoro_mobile/route/routes.dart';
import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/ui/transactions/popup_view.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_text_field.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final requestProvider =
ChangeNotifierProvider.autoDispose<RequestViewModel>((ref) {
  ref.onDispose(() {});
  final viewModel = locator.get<RequestViewModel>();
  viewModel.getRequest();
  viewModel.getPaymentProcessor();
  viewModel.getUser();
  return viewModel;
});

final _requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(requestProvider).viewState;
});
final requestStateProvider = Provider.autoDispose<ViewState>((ref) {
  return ref.watch(_requestStateProvider);
});

class RequestsPage extends StatefulHookWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  TextEditingController _inputController = TextEditingController();
  bool focus = false;
  bool focusPopStatus = false;
  bool focusPopType = false;
  bool focusPopInput = false;
  String selectedOption = "Status";
  String selectedStatus = "DESTROY";
  String selectedType = "WITHDRAW";
  String inputValue = "";

  // @override
  // void initState() {
  //   context.read(requestProvider).getRequest();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print("Request view");
    ViewState viewState = useProvider(requestStateProvider);
    List<RequestData>? requestList =
        useProvider(requestProvider).requestList;
    GetUserData? userData = useProvider(requestProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";


    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    OverViewToolBar(
                      AppString.requests,
                      userData?.avatar.toString() ?? "",
                      trailingIconClicked: () => null,
                      initials: initials,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 23),
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: const Color(0xfffffffff)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 18,
                                          ),
                                          AppFontsStyle.getAppTextViewBold(
                                            "Purchase Request",
                                            color: Pallet.colorBlue,
                                            weight: FontWeight.w600,
                                            size: AppFontsStyle.textFontSize10,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "Buy Dhoro tokens with ease and join the Dhoro community.",
                                        weight: FontWeight.w700,
                                        size: AppFontsStyle.textFontSize16,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pushNamed(AppRoutes.buy);
                                        },
                                        child: Container(
                                            height: 50,
                                            width: 137,
                                            child: Center(
                                              child: AppFontsStyle.getAppTextViewBold(
                                                  'BUY DHORO',
                                                  size: AppFontsStyle.textFontSize12,
                                                  color: Pallet.colorWhite,
                                                  textAlign: TextAlign.center),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(2)),
                                              color: Pallet.colorBlue,
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppImages.icBuyer),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 23),
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: const Color(0xfffffffff)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 18,
                                          ),
                                          AppFontsStyle.getAppTextViewBold(
                                            "Withdrawal Request",
                                            color: Pallet.colorBlue,
                                            weight: FontWeight.w600,
                                            size: AppFontsStyle.textFontSize10,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      AppFontsStyle.getAppTextViewBold(
                                        "Seamlessly convert your Dhoro tokens to fiat at current rates.",
                                        weight: FontWeight.w700,
                                        size: AppFontsStyle.textFontSize16,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pushNamed(AppRoutes.withdraw);
                                        },
                                        child: Container(
                                            height: 50,
                                            width: 137,
                                            child: Center(
                                              child: AppFontsStyle.getAppTextViewBold(
                                                  'SELL DHORO',
                                                  size: AppFontsStyle.textFontSize12,
                                                  color: Pallet.colorBlue,
                                                  textAlign: TextAlign.center),
                                            ),
                                            decoration: BoxDecoration(
                                              border:  Border.all(width: 1.0, color: Pallet.colorBlue),
                                              borderRadius: BorderRadius.all(Radius.circular(2)),)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppImages.icWithdraw),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: AppFontsStyle.getAppTextViewBold(
                        AppString.requests,
                        weight: FontWeight.w700,
                        size: AppFontsStyle.textFontSize16,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.icFilter),
                            SizedBox(
                              width: 8,
                            ),
                            AppFontsStyle.getAppTextViewBold(
                              "Latest 5 from a total of ${requestList.length} transactions",
                              weight: FontWeight.w500,
                              size: AppFontsStyle.textFontSize10,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap:() {
                                  setState(() {
                                    print("view clicked");
                                    focus = !focus;
                                    focusPopInput = false;
                                    focusPopStatus = false;
                                    focusPopType = false;
                                  });
                                },
                                child: SvgPicture.asset(AppImages.iconMenu)),
                          ],
                        )
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TransactionHeader(),
                    requestList.isNotEmpty == true
                        ? viewState == ViewState.Loading
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                      padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 24),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: const Color(0xfffffffff)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(requestList.length, (index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TransactionList(
                                                (){},
                                            requestList[index]
                                                .pk ?? "",
                                            requestList[index]
                                                .status ?? "",
                                            requestList[index]
                                                .amount
                                                .toString(),
                                            requestList[index]
                                                .payment?.user ?? ""
                                        ),
                                        // SizedBox(
                                        //   height: 8,
                                        // ),
                                        Divider(
                                          height: 1,
                                          color: Pallet.colorBlue.withOpacity(0.3),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    )
                        : buildEmptyView(),
                  ],
                ),
              ]),
            ),

            Visibility(
              visible: focus == true,
              child: Padding(
                padding: const EdgeInsets.only(top: 110.0, right: 24),
                child: Align(
                    alignment: Alignment.topRight,
                    child: popView(
                          (){
                        setState(() {
                          print("pressed status");
                          focus = false;
                          focusPopInput = false;
                          focusPopType = false;
                          selectedOption = "status";
                          focusPopStatus = !focusPopStatus;
                        });
                      },
                          (){
                        setState(() {
                          print("pressed Type");
                          focus = false;
                          focusPopStatus = false;
                          focusPopInput = false;
                          selectedOption = "type";
                          focusPopType = !focusPopType;
                        });
                      },
                          () {
                        setState(() {
                          print("pressed WID");
                          focus = false;
                          focusPopStatus = false;
                          focusPopType = false;
                          focusPopInput = !focusPopInput;
                          selectedOption = "wid";
                        });
                      },
                          () {
                        setState(() {
                          print("pressed Total");
                          focus = false;
                          focusPopStatus = false;
                          focusPopType = false;
                          focusPopInput = !focusPopInput;
                          selectedOption = "total";
                        });
                      },
                    )),
              ),
            ),
            Visibility(
              visible: focusPopStatus == true,
              child: Padding(
                padding: const EdgeInsets.only(top: 210.0, right: 24),
                child: Align(
                    alignment: Alignment.topRight,
                    child: statusPopView(
                          () {
                        setState(() {
                          print("pressed PENDING");
                          selectedStatus = "PENDING";
                          focusPopStatus = false;
                          context.read(requestProvider).getRequestQuery("$selectedOption=$selectedStatus");
                        });
                      },
                          () {
                        setState(() {
                          print("pressed APPROVED");
                          selectedStatus = "APPROVED";
                          focusPopStatus = false;
                          context.read(requestProvider).getRequestQuery("$selectedOption=$selectedStatus");
                        });
                        },
                              () {
                            setState(() {
                              print("pressed DECLINED");
                              selectedStatus = "DECLINED";
                              focusPopStatus = false;
                              context.read(requestProvider).getRequestQuery("$selectedOption=$selectedStatus");
                            });
                            },
                    )
                ),
              ),
            ),
            Visibility(
              visible: focusPopType == true,
              child: Padding(
                padding: const EdgeInsets.only(top: 210.0, right: 24),
                child: Align(
                    alignment: Alignment.topRight,
                    child: typePopView(
                          () {
                        setState(() {
                          print("pressed WITHDRAW");
                          selectedType = "WITHDRAW";
                          focusPopType = false;
                          context.read(requestProvider).getRequestQuery("$selectedOption=$selectedType");
                        });
                      },
                          () {
                        setState(() {
                          print("pressed PURCHASE");
                          selectedType = "PURCHASE";
                          focusPopType = false;
                          context.read(requestProvider).getRequestQuery("$selectedOption=$selectedType");
                        });
                      },
                    )
                ),
              ),
            ),
            Visibility(
                visible: focusPopInput,
                child: Padding(
                  padding: const EdgeInsets.only(top: 210.0, right: 24),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: inputPopView(
                        selectedOption.contains("wid") ? "Enter Wallet ID"
                            : "Enter Total",
                            (value){
                          setState(() {
                            inputValue = value.trim();
                            context.read(requestProvider).getRequestQuery("$selectedOption=$inputValue");
                          });
                        },
                            (value) {
                          if (inputValue.isEmpty) {
                            return "Field can not be empty";
                          }
                          return null;
                        },
                        _inputController,
                        selectedOption.contains("total")
                            ? TextInputType.numberWithOptions(decimal: true)
                            : TextInputType.text),
                  ),
                )),
          ],

        ),
      ),
    );
  }

  Widget popView(
      Function()? onPressedStatus,
      Function()? onPressedType,
      Function()? onPressedWID,
      Function()? onPressedTotal
      ) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PopupView(
              title: "Status",
              onPressed: onPressedStatus,
            ),
            SizedBox(height: 16,),
            PopupView(
              title: "Type",
              onPressed: onPressedType,
            ),
            SizedBox(height: 16,),
            PopupView(
              title: "Wallet ID",
              onPressed: onPressedWID,
            ),
            SizedBox(height: 16,),
            PopupView(
              title: "Total",
              onPressed: onPressedTotal,
            ),
            context.read(requestProvider).viewState == ViewState.Loading ? Center(child: CircularProgressIndicator())
                :GestureDetector(
              onTap: (){
                setState(() {
                  focusPopStatus = false;
                  focus= false;
                  focusPopInput= false;
                  context.read(requestProvider).getRequest();
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: AppFontsStyle.getAppTextView(
                    "Clear filter",
                    size: 14,
                    textAlign: TextAlign.center,
                    color: Pallet.colorRed),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget typePopView(
      Function()? onPressedWithdraw,
      Function()? onPressedPurchase
      ) {
    return Container(
      height: 105,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PopupView(
              title: "WITHDRAW",
              onPressed: onPressedWithdraw,
            ),
            SizedBox(height: 16,),
            PopupView(
              title: "PURCHASE",
              onPressed: onPressedPurchase,
            ),
          ],
        ),
      ),
    );
  }

  Widget statusPopView(
      Function()? onPressedPending,
      Function()? onPressedApproved,
      Function()? onPressedDeclined
      ) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PopupView(
              title: "PENDING",
              onPressed: onPressedPending,
            ),
            SizedBox(height: 16,),
            PopupView(
              title: "APPROVED",
              onPressed: onPressedApproved,
            ),
            SizedBox(height: 16,),
            PopupView(
              title: "DECLINED",
              onPressed: onPressedDeclined,
            ),
          ],
        ),
      ),
    );
  }

  Widget inputPopView(
      String label,
      Function(String)? onChanged,
      FormFieldValidator<String>? validator,
      TextEditingController? controller,
      TextInputType? keyboardType
      ) {
    return Container(
      //height: 55,
      width: 182,
      decoration: BoxDecoration(
        color: Pallet.colorWhite,
        //border: Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppFormField(
          label: label,
          width: MediaQuery.of(context).size.width - 50,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget buildEmptyView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.0,
          ),
          Container(
            child: SvgPicture.asset("assets/images/ic_notifications.svg"),
          ),
          SizedBox(
            height: 24.0,
          ),
          AppFontsStyle.getAppTextViewBold("No request yet",
              size: 14, textAlign: TextAlign.center, color: Pallet.colorBlue),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: AppFontsStyle.getAppTextView(
                "You might need to interact more.",
                size: 14,
                textAlign: TextAlign.center,
                color: Pallet.colorBlue),
          ),
        ],
      ),
    );
  }
}

class TransactionList extends StatefulWidget {
  Function()? onItemClicked;
  String transId;
  String status;
  String value;
  String senderId;

  TransactionList(
      this.onItemClicked, this.transId, this.status, this.value, this.senderId,
      {Key? key})
      : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 9.0, right: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.icEye),
            SizedBox(
              width: 12,
            ),
            Container(
              width: 90,
              child: Text(widget.transId,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: GoogleFonts.manrope(
                      color: Pallet.colorBlue,
                      fontSize: AppFontsStyle.textFontSize12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      height: 1.5)),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: 58,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: widget.status.contains("PENDING")
                      ? Pallet.colorYellow : widget.status.contains("DECLINED")
                      ? Pallet.colorRed : Pallet.colorYellow.withOpacity(0.4)),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: AppFontsStyle.getAppTextView(
                  widget.status,
                  color: Pallet.colorBlue,
                  textAlign: TextAlign.center,
                  size: AppFontsStyle.textFontSize8,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: 35,
              child: Text(widget.value,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: GoogleFonts.manrope(
                      color: Pallet.colorBlue,
                      fontSize: AppFontsStyle.textFontSize12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      height: 1.5)),
            ),
            // AppFontsStyle.getAppTextView(
            //   widget.value,
            //   color: Pallet.colorBlue,
            //   size: AppFontsStyle.textFontSize12,
            // ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              child: Container(
                child: Text(widget.senderId,
                    textAlign: TextAlign.left,
                    //maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: GoogleFonts.manrope(
                        color: Pallet.colorBlue,
                        fontSize: AppFontsStyle.textFontSize12,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        height: 1.5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}