import 'dart:math';

import 'package:flutter/material.dart';

class PageToggler extends StatefulWidget {
  final PageController controller;
  final String leftTitle;
  final String rightTitle;
  final ValueChanged<int> onChange;

  PageToggler({
    Key key,
    this.controller,
    this.leftTitle,
    this.rightTitle,
    this.onChange,
  }) : super(key: key);

  @override
  _PageTogglerState createState() => _PageTogglerState();
}

class _PageTogglerState extends State<PageToggler> {
  Color _left = Colors.black;
  Color _right = Colors.white;

  PageController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller?.addListener(onPageChanged);
  }

  @override
  void dispose() {
    controller?.removeListener(onPageChanged);
    super.dispose();
  }

  void onPageChanged() {
    var page = controller.page;
    print('controller.page: $page');
    if (page <= 0.0) {
      _left = Colors.black;
      _right = Colors.white;
      setState(() {});
    } else if (page >= 1.0) {
      _left = Colors.white;
      _right = Colors.black;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: CustomPaint(
        painter: _TabIndicationPainter(pageController: controller),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => _onButtonPressed(0),
                child: Text(
                  widget.leftTitle,
                  style: TextStyle(color: _left, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => _onButtonPressed(1),
                child: Text(
                  widget.rightTitle,
                  style: TextStyle(color: _right, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(int index) {
    widget.controller?.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}

class _TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  _TabIndicationPainter({
    this.dxTarget = 125.0,
    this.dxEntry = 25.0,
    this.radius = 21.0,
    this.dy = 25.0,
    this.pageController,
  }) : super(repaint: pageController) {
    painter = Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent = (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);
    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = Path();
    path.addArc(Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, Color(0xFFfbab66), 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(_TabIndicationPainter oldDelegate) => true;
}
