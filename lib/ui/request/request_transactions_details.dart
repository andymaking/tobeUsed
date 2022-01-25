import 'dart:io';

import 'package:dhoro_mobile/data/remote/model/request/request_data.dart';
import 'package:dhoro_mobile/data/remote/model/user/get_user_model.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:dhoro_mobile/ui/request/requests.dart' as sharedProvider;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class RequestTransactionsDetailsPage extends HookWidget {
  final RequestData data;

  const RequestTransactionsDetailsPage({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavBarColor(
        Pallet.colorWhite, Pallet.colorWhite, false, false);
    GetUserData? userData = useProvider(sharedProvider.requestProvider).user;
    final initials =
        "${userData?.firstName?[0] ?? ""}${userData?.lastName?[0] ?? ""}";
    List<RequestData>? userTransactions =
        useProvider(sharedProvider.requestProvider).requestList;

    DateTime now = DateTime.parse(data.created.toString());
    final date = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OverViewToolBar(
                "Transaction details",
                userData?.avatar.toString() ?? "",
                trailingIconClicked: () => null,
                initials: initials,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 20, bottom: 16),
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset("assets/images/arrow_back.svg")),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 16),
                            child: Container(
                              //height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Pallet.colorWhite,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          AppFontsStyle.getAppTextViewBold(
                                            AppString.transactionId + ":",
                                            color: Pallet.colorBlue,
                                            size: AppFontsStyle.textFontSize12,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: AppFontsStyle
                                                .getAppTextViewBold(
                                              data.pk,
                                              color: Pallet.colorBlue,
                                              size:
                                                  AppFontsStyle.textFontSize12,
                                            ),
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Pallet.colorGrey,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(children: [
                                        AppFontsStyle.getAppTextViewBold(
                                          "Type:",
                                          color: Pallet.colorBlue,
                                          size: AppFontsStyle.textFontSize12,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child:
                                              AppFontsStyle.getAppTextViewBold(
                                            data.type,
                                            color: Pallet.colorBlue,
                                            size: AppFontsStyle.textFontSize12,
                                          ),
                                        )),
                                      ]),
                                           SizedBox(
                                             height: 16,
                                           ),
                                           Divider(
                                             height: 1,
                                             color: Pallet.colorGrey,
                                           ),
                                           SizedBox(
                                             height: 16,
                                           ),
                                           Row(
                                             children: [
                                               AppFontsStyle.getAppTextViewBold(
                                                 "Amount:",
                                                 color: Pallet.colorBlue,
                                                 size: AppFontsStyle
                                                     .textFontSize12,
                                               ),
                                               SizedBox(
                                                 width: 8,
                                               ),
                                               Expanded(
                                                   child: Padding(
                                                 padding: const EdgeInsets.only(
                                                     right: 8.0),
                                                 child: AppFontsStyle
                                                     .getAppTextViewBold(
                                                   data.amount!
                                                           .toStringAsFixed(2) +" "+
                                                       data.currencyType
                                                           .toString(),
                                                   color: Pallet.colorBlue,
                                                   size: AppFontsStyle
                                                       .textFontSize12,
                                                 ),
                                               )),
                                             ],
                                           ),
                                           SizedBox(
                                             height: 16,
                                           ),
                                           Divider(
                                             height: 1,
                                             color: Pallet.colorGrey,
                                           ),
                                           SizedBox(
                                             height: 16,
                                           ),
                                           Row(
                                             children: [
                                               AppFontsStyle.getAppTextViewBold(
                                                 "Value:",
                                                 color: Pallet.colorBlue,
                                                 size: AppFontsStyle
                                                     .textFontSize12,
                                               ),
                                               SizedBox(
                                                 width: 8,
                                               ),
                                               Expanded(
                                                   child: Padding(
                                                 padding: const EdgeInsets.only(
                                                     right: 8.0),
                                                 child: AppFontsStyle
                                                     .getAppTextViewBold(
                                                   "\$ ${data.value}",
                                                   color: Pallet.colorBlue,
                                                   size: AppFontsStyle
                                                       .textFontSize12,
                                                 ),
                                               )),
                                             ],
                                           ),
                                           SizedBox(
                                             height: 16,
                                           ),
                                           Divider(
                                             height: 1,
                                             color: Pallet.colorGrey,
                                           ),
                                           SizedBox(
                                             height: 16,
                                           ),
                                           Row(
                                             children: [
                                               AppFontsStyle.getAppTextViewBold(
                                                 "NGN:",
                                                 color: Pallet.colorBlue,
                                                 size: AppFontsStyle
                                                     .textFontSize12,
                                               ),
                                               SizedBox(
                                                 width: 8,
                                               ),
                                               Text("${getCurrency(context).currencySymbol}"),
                                               Expanded(
                                                   child: Padding(
                                                 padding: const EdgeInsets.only(
                                                     right: 8.0),
                                                 child: AppFontsStyle
                                                     .getAppTextViewBold(
                                                   " ${data.totalNgn}",
                                                   color: Pallet.colorBlue,
                                                   size: AppFontsStyle
                                                       .textFontSize12,
                                                 ),
                                               )),
                                             ],
                                           ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Divider(
                                            height: 1,
                                            color: Pallet.colorGrey,
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              AppFontsStyle.getAppTextViewBold(
                                                "Txn Fee:",
                                                color: Pallet.colorBlue,
                                                size: AppFontsStyle
                                                    .textFontSize12,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: AppFontsStyle
                                                    .getAppTextViewBold(
                                                  "\$ ${data.transactionFee}",
                                                  color: Pallet.colorBlue,
                                                  size: AppFontsStyle
                                                      .textFontSize12,
                                                ),
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Divider(
                                            height: 1,
                                            color: Pallet.colorGrey,
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              AppFontsStyle.getAppTextViewBold(
                                                AppString.status + ":",
                                                color: Pallet.colorBlue,
                                                size: AppFontsStyle
                                                    .textFontSize12,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                width: 58,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(3)),
                                                    color: data.status!
                                                            .contains("PENDING")
                                                        ? Pallet.colorYellow
                                                        : data.status!.contains(
                                                                "DECLINED")
                                                            ? Pallet.colorRed
                                                            : Pallet.colorYellow
                                                                .withOpacity(
                                                                    0.4)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 3),
                                                  child: AppFontsStyle
                                                      .getAppTextView(
                                                    data.status,
                                                    color: Pallet.colorBlue,
                                                    textAlign: TextAlign.center,
                                                    size: AppFontsStyle
                                                        .textFontSize8,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Divider(
                                            height: 1,
                                            color: Pallet.colorGrey,
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              AppFontsStyle.getAppTextViewBold(
                                                "Date:",
                                                color: Pallet.colorBlue,
                                                size: AppFontsStyle
                                                    .textFontSize12,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: AppFontsStyle
                                                    .getAppTextViewBold(
                                                  date,
                                                  color: Pallet.colorBlue,
                                                  size: AppFontsStyle
                                                      .textFontSize12,
                                                ),
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 24,
                                          ),

                                    ]),
                              ),
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  NumberFormat getCurrency(context) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format;
  }
}
