import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomDraggableScreen extends StatefulWidget {
  const BottomDraggableScreen({Key? key}) : super(key: key);

  @override
  _BottomDraggableScreenState createState() => _BottomDraggableScreenState();
}

class _BottomDraggableScreenState extends State<BottomDraggableScreen> {
  double initialPercentage = 0.06;
  late DraggableScrollableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: mounted,
      minChildSize: initialPercentage,
      initialChildSize: initialPercentage,
      controller: _controller,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            alignment: Alignment.topRight,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(77, 236, 140, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Audio description",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                IconButton(
                  splashRadius: 25,
                  icon: SvgPicture.asset(
                    "assets/icons/fullscreen.svg",
                    height: 25,
                  ),
                  padding: const EdgeInsets.only(right: 20),
                  onPressed: () async {
                    if (_controller.size < 1) {
                      _controller.animateTo(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    } else if (_controller.size > .8) {
                      _controller.animateTo(0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
