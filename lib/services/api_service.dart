import 'package:http/http.dart' as http;
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/movie_model.dart';
import 'package:netflix/models/popular_tv_series.dart';
import 'package:netflix/models/top_rated_movies_model.dart';
import 'package:netflix/models/trending_movies_model.dart';
import 'package:netflix/models/upcoming_movies_model.dart';

class ApiService {
  // Now Playing Movies
  Future<Movie?> fetchMovies() async {
    try {
      const endPoint = "/movie/now_playing";
      final apiUrl = "$baseUrl$endPoint?api_key=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieFromJson(response.body);
      } else {
        throw Exception("Failed to load movies.");
      }
    } catch (e) {
      print("Error Fetching Movies: $e");
      return null;
    }
  }

  // Now Upcoming Movies
  Future<UpcomingMovies?> upcomingMovies() async {
    try {
      const endPoint = "/movie/upcoming";
      final apiUrl = "$baseUrl$endPoint?api_key=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return upcomingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies.");
      }
    } catch (e) {
      print("Error Fetching Movies: $e");
      return null;
    }
  }

  // Now Trending Movies
  Future<TrendingMovies?> trendingMovies() async {
    try {
      const endPoint = "trending/movie/day";
      final apiUrl = "$baseUrl$endPoint?api_key=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return trendingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies.");
      }
    } catch (e) {
      print("Error Fetching Movies: $e");
      return null;
    }
  }

  // Top Rated Movies
  Future<TopRatedMovies?> topRatedMovies() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint?api_key=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return topRatedMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies.");
      }
    } catch (e) {
      print("Error Fetching Movies: $e");
      return null;
    }
  }

  // Popular TV Seres
  Future<PopularTvSeries?> popularTVSeries() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint?api_key=$apiKey";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return popularTvSeriesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies.");
      }
    } catch (e) {
      print("Error Fetching Movies: $e");
      return null;
    }
  }
}
