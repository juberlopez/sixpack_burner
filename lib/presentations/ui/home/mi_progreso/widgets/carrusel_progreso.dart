import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiver/iterables.dart';

class CarouselProgreso extends StatefulWidget {
  final List<String> lista;

  const CarouselProgreso({Key? key, required this.lista}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselProgresoState();
  }
}

class _CarouselProgresoState extends State<CarouselProgreso> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> contenidoItems = widget.lista
        .map(
          (item) => Container(
            //height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              image:
                  DecorationImage(image: AssetImage(item), fit: BoxFit.cover),
            ),
          ),
        )
        .toList();
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(children: [
            CarouselSlider(
              items: contenidoItems,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  //enlargeCenterPage: true,
                  //aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Positioned(
              bottom: 5,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: enumerate(widget.lista).map((e) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 1.0),
                          shape: BoxShape.circle,
                          color: _current == e.index
                              ? Colors.blueAccent
                              : Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
