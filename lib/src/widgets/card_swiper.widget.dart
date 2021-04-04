import 'package:flutter/material.dart';
import 'package:films/src/models/peliculas.model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Film> films;

  const CardSwiperWidget({@required this.films, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      // width: _screenSize.width * 0.7,
      // height: _screenSize.height * 0.5,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(films[index].getPosterImg()),
              placeholder: AssetImage('assets/nimage.jpg'),
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: films.length,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        // itemWidth:DeviceSize.width(context),
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
