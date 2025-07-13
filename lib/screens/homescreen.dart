import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/movie_model.dart';
import 'package:netflix/models/popular_tv_series.dart';
import 'package:netflix/models/top_rated_movies_model.dart';
import 'package:netflix/models/trending_movies_model.dart';
import 'package:netflix/models/upcoming_movies_model.dart';
import 'package:netflix/services/api_service.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final ApiService apiService = ApiService();
  late Future<Movie?> movieData;
  late Future<UpcomingMovies?> upcomingMovieData;
  late Future<TrendingMovies?> trendingMovieData;
  late Future<TopRatedMovies?> topRatedMovieData;
  late Future<PopularTvSeries> popularTVSeriesData;

  @override
  void initState() {
    movieData = apiService.fetchMovies();
    upcomingMovieData = apiService.upcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset('assets/logo.png', height: 50),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, size: 27, color: Colors.white),
                  ),
                  Icon(Icons.download_sharp, color: Colors.white, size: 27),
                  SizedBox(width: 10),
                  Icon(Icons.cast, size: 27, color: Colors.white),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text(
                      "TV Shows",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),

                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Text(
                      "Movies",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white38),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white38),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 450,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: FutureBuilder(
                      future: movieData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error ${snapshot.error}"));
                        } else if (snapshot.hasData &&
                            snapshot.data!.results != null) {
                          final movies = snapshot.data!.results;

                          print("Fetched movies: ${movies.length}");
                          print(
                            "Poster path of first movie: ${movies[0].posterPath}",
                          );

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              itemCount: movies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 450,
                                    width: 388,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),

                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                          "$imageUrl${movie.posterPath}",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              "Problem to fetch data.",
                              style: TextStyle(color: Colors.amber),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  Positioned(
                    bottom: -40,
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Text(
                                  "Play",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 30),
                                Text(
                                  "My List",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Upcoming movie section
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                "Upcoming Movies",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 130,
                child: FutureBuilder(
                  future: upcomingMovieData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error ${snapshot.error}"));
                    } else if (snapshot.hasData &&
                        snapshot.data!.results != null) {
                      final upcoming = snapshot.data!.results;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: upcoming.length,
                        itemBuilder: (context, index) {
                          final movie = upcoming[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              height: 130,
                              width: 110,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                image: DecorationImage(
                                  fit: BoxFit.cover,

                                  image: CachedNetworkImageProvider(
                                    "$imageUrl${movie.posterPath}",
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text(
                        "No upcoming movies found",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  },
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
