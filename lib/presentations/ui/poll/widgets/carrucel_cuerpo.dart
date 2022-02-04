import 'package:sixpackburner/presentations/ui/poll/poll_cubit/poll_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/iterables.dart';


/*class CarouselAdvertisingBanner extends StatelessWidget {
  const CarouselAdvertisingBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 242,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<PollCubit, PollState>(
          buildWhen: (previous, current) =>
              previous.advertisingBannerList != current.advertisingBannerList,
          builder: (context, state) {
            List<Widget> contenidoItems = [];
            if (state.advertisingBannerList.isNotEmpty) {
          contenidoItems = state.advertisingBannerList
              .map(
                (item) => Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Container(
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
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: FadeInImage(
                                image: NetworkImage(item.urlImage),
                                placeholder:
                                    AssetImage('assets/images/icon.png'),
                                fit: BoxFit.cover,
                                //width: double.infinity,
                              )),
                        ),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.id,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Quicksand',
                                        color: Colors.white,
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
}*/



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
                      height: 270,
                        autoPlay: false,
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