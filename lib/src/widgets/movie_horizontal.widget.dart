import 'package:films/src/models/peliculas.model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Film> films;

  final _pageCtrl = PageController(initialPage: 1, viewportFraction: 0.3);

  final Function nextPage;

  MovieHorizontal({Key key, @required this.films, @required this.nextPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageCtrl.addListener(() {
      if (_pageCtrl.position.pixels >=
          _pageCtrl.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
        height: _screenSize.height * 0.25,
        child: PageView.builder(
          pageSnapping: false,
          controller: _pageCtrl,
          itemCount: films.length,
          itemBuilder: (BuildContext context, int i) =>
              _card(context, films[i]),
        ));
  }

  Widget _card(BuildContext context, Film film) => Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/nimage.jpg'),
                image: NetworkImage(film.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

  List<Widget> _cards(BuildContext context) {
    return films
        .map((Film film) => Container(
              margin: EdgeInsets.only(right: 15.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/nimage.jpg'),
                      image: NetworkImage(film.getPosterImg()),
                      fit: BoxFit.cover,
                      height: 130.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    film.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ))
        .toList();
  }
}
