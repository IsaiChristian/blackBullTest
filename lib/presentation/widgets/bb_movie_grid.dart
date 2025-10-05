import 'package:black_bull/domain/entities/movie_entity.dart';
import 'package:black_bull/presentation/widgets/bb_loading_logo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BbMovieGrid extends StatelessWidget {
  const BbMovieGrid({
    super.key,
    required this.movieList,
  });

  final List<MovieEntity> movieList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
     shrinkWrap: true, // <- evita que tome altura infinita
              physics: NeverScrollableScrollPhysics(), // <- evita doble scroll
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2, // 2 columns
         crossAxisSpacing: 16,
         mainAxisSpacing: 16,
         childAspectRatio: 0.7,
       ), 
       itemCount: movieList.length , 
       itemBuilder: (context, index) {
        
         return Card(
           elevation: 4,
           child: Column(
             crossAxisAlignment: .stretch,
             children: [
               
               Expanded(
                 child: Stack(
                   children: [
                     Positioned.fill(
                       child: Container(
                        height: double.infinity,
                         color: Colors.grey[400],
                         child: Icon(Icons.movie, size: 64, color: Colors.grey[700]),
                       ),
                     ),
                     Center(
                       child: SizedBox(
                         width: double.infinity,
                         
                         child: CachedNetworkImage(
                           imageUrl: 'https://image.tmdb.org/t/p/w154${movieList[index].posterPath}',
                           fit: BoxFit.cover,
                           placeholder: (context, url) => Center(child: BbLoadingLogo(onlyIcon: true, duration: Duration(microseconds: 300),)),
                           errorWidget: (context, url, error) => Icon(Icons.error),
                         ),
                       ),
                     ),
                 
                   ],
                 ),
               ),
             
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(
                   movieList[index].title, 
                   style: TextStyle(fontWeight: FontWeight.bold),
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
             ],
           ),
         );
       },
     );
  }
}

