import 'package:e_grocery/src/components/welcome_screen_components.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreenItem StoreWelcomeScreenItem;

  WelcomeScreen(this.StoreWelcomeScreenItem);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isConnected = false;
  AnimationController _aController;

  Animation<Offset> _textHeaderSlide;
  Animation<double> _textHeaderFade;

  Animation<Offset> _textSlide;
  Animation<double> _textFade;

  Animation _buttonPop;

  void checkNetwork() async {
    _isConnected = await TestConnection.checkForConnection();
  }

  @override
  void initState() {
    checkNetwork();

    _aController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _aController.forward();

    _textHeaderSlide = Tween<Offset>(
      begin: Offset(.4, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(0, .3, curve: Curves.easeOut),
    ));

    _textHeaderFade = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0,
        .6,
        curve: Curves.easeOut,
      ),
    );

    _textSlide = Tween<Offset>(
      begin: Offset(.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.3, .6, curve: Curves.easeOut),
    ));

    _textFade = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0.3,
        .9,
        curve: Curves.easeOut,
      ),
    );

    _buttonPop = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0.7,
        1,
        curve: Curves.easeIn,
      ),
    ));

    _aController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _aController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    WelcomeScreenButton btn = widget.StoreWelcomeScreenItem.btn;
    String details = widget.StoreWelcomeScreenItem.details;

    String header = widget.StoreWelcomeScreenItem.header;

    Widget blob1 = widget.StoreWelcomeScreenItem.blob1;
    Widget blob2 = widget.StoreWelcomeScreenItem.blob2;
    Widget blob3 = widget.StoreWelcomeScreenItem.blob3;
    Color bgColor = widget.StoreWelcomeScreenItem.bgColor;

    return Stack(
      children: [
        Container(
          color: bgColor,
        ),
        blob1,
        blob2,
        blob3,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(
                flex: 7,
              ),
              FadeTransition(
                opacity: _textHeaderFade,
                child: SlideTransition(
                  position: _textHeaderSlide,
                  child: FittedBox(
                    child: Text(
                      header,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: screenWidth * .11,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              FadeTransition(
                opacity: _textFade,
                child: SlideTransition(
                  position: _textSlide,
                  child: Text(
                    details,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: screenWidth * .045,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        height: 1.5,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _buttonPop,
                    child: RaisedButton(
                      color: btn.color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .09,
                          vertical: screenHeight * .025),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          btn.text,
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: screenWidth10p * 2.4),
                        ),
                      ),
                      elevation: 1,
                      onPressed: btn.navigationFunction,
                    ),
                  )
                ],
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WelcomeScreenItem {
  WelcomeScreenButton btn;
  String details;

  String header;

  Widget blob1;
  Widget blob2;
  Widget blob3;

  Color bgColor;

  WelcomeScreenItem(
      {this.btn,
      this.details,
      this.header,
      this.blob1,
      this.blob2,
      this.blob3,
      this.bgColor});
}
