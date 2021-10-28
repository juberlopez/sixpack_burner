import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TypeImageSource extends StatefulWidget {
  final Function onPressed;

  const TypeImageSource({Key? key, required this.onPressed}) : super(key: key);

  @override
  _TypeImageSourceState createState() => _TypeImageSourceState();
}

class _TypeImageSourceState extends State<TypeImageSource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          // height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(15.0) //                 <--- border radius here
                ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selecciona una opción",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      return widget.onPressed(ImageSource.camera);
                    },
                    child: Container(
                      height: 110,
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            child: Image(
                              image: AssetImage('assets/images/takephoto.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Tomar foto",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      return widget.onPressed(ImageSource.gallery);
                    },
                    child: Container(
                      height: 110,
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            child: Image(
                              image: AssetImage('assets/images/gallery.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Imagen de galeria",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
