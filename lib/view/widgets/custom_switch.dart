import 'package:wocontacts/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSwicth extends StatefulWidget {
  const CustomSwicth({super.key,required this.onChanged,required this.value,required this.active,required this.inActive});

  final void Function(bool value) onChanged;
  final bool value;
  final String active;
  final String inActive;

  @override
  State<CustomSwicth> createState() => _CustomSwicthState();
}

class _CustomSwicthState extends State<CustomSwicth> {
  double _switchWidth = 100;
  double _switchHeight =30;

  Duration _animationDuration=Duration(microseconds: 300);
  Duration _animationDurationThumb =Duration(microseconds: 300);

  bool isNight=true;

  void _onTapSwitch() {
    setState(() {
      isNight = !isNight;
      widget.onChanged(isNight);
    });
  }

  @override
  void initState() {
    setState(() {
      isNight=widget.value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: AnimatedOpacity(
          opacity: isNight ? 0 : 1,
          duration: _animationDuration,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        )),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: _onTapSwitch,
                child: Container(
                  width: _switchWidth,
                  height: _switchHeight,
                  child: Stack(
                    children: [
                      //night
                      AnimatedPositioned(
                        duration: _animationDuration,
                        width: isNight ? _switchWidth :0,
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: _switchWidth,
                          height: _switchHeight,
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                             borderRadius: BorderRadius.circular(100),
                             border: Border.all(width:2,color: Colors.grey.shade300),

                          ),
                          child:  Padding(
                            padding:  EdgeInsets.only(right:10,),
                            child: Text(widget.inActive,maxLines: 1,overflow:TextOverflow.ellipsis,),
                          ),
                        ),),
                      //moon
                      AnimatedPositioned(
                          duration: _animationDuration,
                          top: 0,
                          bottom: 0,
                          left: isNight ? 0 : (_switchWidth - _switchHeight),
                          child: AnimatedOpacity(
                            opacity: isNight ? 1 : 0,
                            duration: _animationDurationThumb,
                            child:  Container(
                              margin: const EdgeInsets.only(left:5),
                              height:25,
                              width: 25,
                              decoration:  const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle
                              ),
                            ),
                          )
                      ),
                      //day
                      AnimatedPositioned(
                          duration: _animationDuration,
                          width: isNight ? 0 : _switchWidth,
                          top: 0,
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: _switchWidth,
                            height: _switchHeight,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width:2,color: Colors.grey.shade300),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.only(left:5,),
                              child: Text(widget.active,maxLines: 1,overflow:TextOverflow.ellipsis,),
                            ),
                          )
                      ),
                      AnimatedPositioned(
                          duration: _animationDuration,
                          top: 0,
                          bottom: 0,
                          left: isNight ? 0 : (_switchWidth - _switchHeight),
                          child: AnimatedOpacity(
                            opacity: isNight ? 0 : 1,
                            duration: _animationDuration,
                            child: Container(
                              height:25,
                              width: 25,
                              decoration: const BoxDecoration(
                                  color: AppColors.blue_100,
                                  shape: BoxShape.circle
                              ),
                            ),
                          )
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}