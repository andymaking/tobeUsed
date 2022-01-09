import 'package:dhoro_mobile/utils/change_statusbar_color.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/widgets/button.dart';
import 'package:dhoro_mobile/widgets/size_24_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDialog extends StatelessWidget {
  Function()? onPressed;
  String title;
  bool isError;

  ShowDialog(
      {Key? key, required this.onPressed, required this.title,
          required this.isError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeSystemColor(isError ? Pallet.colorRed : Pallet.colorBlue,);
    return Container(
      color: isError ? Pallet.colorRed : Pallet.colorBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 16.0, bottom: 15),
            child: Text(title,
            style: GoogleFonts.manrope(
            fontSize: 14,
            height: 1.2,
            color: Pallet.colorWhite,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,),
          ),
          ),
          Sized24Container(
            child: AppButton(
                onPressed: isError == true
                    ? (){
                  Navigator.of(context).pop();
                  changeSystemColor(Colors.transparent);
                }
                    : onPressed,
                title: 'Dismiss',
                disabledColor: Pallet.colorGrey,
                titleColor: Pallet.colorWhite,
                enabledColor: isError
                    ? Color.fromRGBO(245, 245, 245, 0.3)
                    : Color.fromRGBO(245, 245, 245, 0.3),
                enabled: true),
          ),
          SizedBox(height: 14,)
        ],
      ),
    );
  }
}

class ShowTwoButtonsDialog extends StatelessWidget {
  Function()? onPressed;
  String title;
  String leftButtonText;
  String rightButtonText;

  ShowTwoButtonsDialog(
      {Key? key, required this.onPressed, required this.title, required this.leftButtonText,
        required this.rightButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    changeSystemColor(Pallet.colorYellow,);
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
      color: Pallet.colorYellow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, left: 16.0, bottom: 15),
            child: Text(title,
              style: GoogleFonts.manrope(
                  fontSize: 14,
                  height: 1.2,
                  color: Pallet.colorWhite,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    changeSystemColor(Colors.transparent);
                    },
                    title: leftButtonText,
                    disabledColor: Pallet.colorGrey,
                    titleColor: Pallet.colorWhite,
                    enabledColor: Color.fromRGBO(245, 245, 245, 0.3),
                    enabled: true),
              ),
              SizedBox(width: 8,),
              Expanded(
                child: AppButton(
                    onPressed: onPressed,
                    title: rightButtonText,
                    disabledColor: Pallet.colorGrey,
                    titleColor: Pallet.colorWhite,
                    enabledColor: Color.fromRGBO(245, 245, 245, 0.3),
                    enabled: true),
              ),
            ],
          )
        ],
      ),
    );
  }
}


Future<T>? showTopModalSheet<T>({ required BuildContext context, required Widget child, }) {
   Navigator.of(context).push(PageRouteBuilder<T>(pageBuilder: (_, __, ___) {
    return TopModalSheet<T>(child: child, );
  }, opaque: false));
}

Future<void> showSucessDialog(BuildContext context, String message, bool success, {onPressed}) async {
  await showTopModalSheet<String>(
      context: context,
      child: ShowDialog(
        title: message,
        isError: !success,
        onPressed: onPressed ?? () {
          Navigator.of(context).pop();
           changeSystemColor(Colors.transparent);
        },
      ));
}


class TopModalSheet<T> extends StatefulWidget {
  final Widget child;
  Color backgroundColor;

  TopModalSheet({Key? key, required this.child, this.backgroundColor = Colors.black54}): super(key: key);

  @override
  TopModalSheetState<T> createState() => TopModalSheetState<T>();
}

class TopModalSheetState<T> extends State<TopModalSheet<T>> with SingleTickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey();
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool _isPoping = false;

  double? get _childHeight {
    final renderBox = _childKey.currentContext?.findRenderObject() as RenderBox ;
    return renderBox.size.height;
  }

  bool get _dismissUnderway => _animationController!.status == AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: -1, end: 0).animate(_animationController!);

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if(!_isPoping) {
          Navigator.pop(context);
          changeSystemColor(Colors.transparent);
        }
      };
    });

    _animationController!.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;

    var change = details.primaryDelta! / (_childHeight!);
    _animationController!.value += change;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;

    if (details.velocity.pixelsPerSecond.dy > 0) return;

    if (details.velocity.pixelsPerSecond.dy > 700) {
      final double flingVelocity = -details.velocity.pixelsPerSecond.dy / _childHeight!;
      if (_animationController!.value > 0.0)
        _animationController!.fling(velocity: flingVelocity);
    } else if (_animationController!.value < 0.5) {
      if (_animationController!.value > 0.0)
        _animationController!.fling(velocity: -1.0);
    } else {
      _animationController!.reverse();
      widget.backgroundColor = Colors.transparent;
      setState(() { });
    }
  }

  Future<bool> onBackPressed({dynamic data}) async {
    _animationController!.reverse();
    widget.backgroundColor = Colors.transparent;
    setState(() {  });

    if(data != null){
      _isPoping = true;
      Navigator.of(context).pop(data);
      changeSystemColor(Colors.transparent);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: GestureDetector(
          onVerticalDragUpdate: _handleDragUpdate,
          onVerticalDragEnd: _handleDragEnd,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: widget.backgroundColor,
              body: Column(
                key: _childKey,
                children: <Widget>[
                  AnimatedBuilder(animation: _animation!, child: widget.child, builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(0.0, MediaQuery.of(context).size.height * _animation!.value, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(behavior: HitTestBehavior.opaque, child: child, onTap: () {}, ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          excludeFromSemantics: true,
        )
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
