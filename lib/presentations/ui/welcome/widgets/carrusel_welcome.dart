import 'package:sixpackburner/presentations/ui/welcome/welcome_cubit/welcome_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiver/iterables.dart';


class CarouselAdvertisingBanner extends StatelessWidget {
  const CarouselAdvertisingBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 242,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<WelcomeCubit, WelcomeState>(
          buildWhen: (previous, current) =>
              previous.listBanner != current.listBanner,
          builder: (context, state) {
            List<Widget> contenidoItems = [];
            if (state.listBanner.isNotEmpty) {
          contenidoItems = state.listBanner
              .map(
                (item) => Container(
                    height: 150,
                    child: Stack(
                      children: [
                       
                        InkWell(
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15.0,
                              bottom: 10.0,
                              top: 0.0,
                            ),
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.title,
                                      textAlign:TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Quicksand',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                   Container(
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Text(
                                        
                                        item.description,
                                        textAlign:TextAlign.center ,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Quicksand',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            /*await  context.read<InitiationCubit>().lugarChanged(item);
                    
                       Navigator.pushNamed(
                                    context, DetailPlaceInitiationPage.routeName);*/
                          },
                        ),
                      ],
                    )),
              )
              .toList();
        }
            return Carrucel(contenidoItems: contenidoItems,);
          }),
    );
  }
}



class Carrucel extends StatefulWidget {
  final List<Widget> contenidoItems;
  const Carrucel({ Key? key, required this.contenidoItems }) : super(key: key);

  @override
  _CarrucelState createState() => _CarrucelState();
}

class _CarrucelState extends State<Carrucel> {
   int _current = 0;
  @override
  Widget build(BuildContext context) {
     return widget.contenidoItems.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Column(children: [
                  CarouselSlider(
                    items: widget.contenidoItems,
                    options: CarouselOptions(
                        autoPlay: true,
                           autoPlayInterval: Duration(seconds: 10),
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: enumerate(widget.contenidoItems).map((e) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF3A3A3A), width: 1.0),
                          shape: BoxShape.circle,
                          color: _current == e.index
                              ? Color(0XFFFFFFFF)
                              : Color(0xFF3A3A3A),
                        ),
                      );
                    }).toList(),
                  ),
                ]),
              ):Container();
  }
}
