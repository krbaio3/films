import 'package:films/src/providers/films.provider.dart';
import 'package:films/src/widgets/movie_horizontal.widget.dart';
import 'package:flutter/material.dart';
import 'package:films/src/widgets/card_swiper.widget.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key key}) : super(key: key);

  final filmsProvider = FilmsProvider();

  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        title: Text('Films'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: _onPressedSearch)
        ],
      ),
      // Para salvar la gota y la barra superior de notificaciones del dispositivo
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCard(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  void _onPressedSearch() {
    print('Press me!');
  }

  Widget _swiperCard() {
    return FutureBuilder(
      future: filmsProvider.getInCinemas(),
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(films: snapshot.data);
        }
        return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'En Taquilla',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: filmsProvider.populatesStream,
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                    films: snapshot.data, nextPage: filmsProvider.getPopular);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
