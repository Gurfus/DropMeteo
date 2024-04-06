import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ForecastTileProvider implements TileProvider {
  final int timeStamps;
  int tileSize = 1;

  ForecastTileProvider({required this.timeStamps});

   @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    DefaultCacheManager cacheManager = DefaultCacheManager();

    final tileKey = "$timeStamps-$zoom-$x-$y";
    
    FileInfo? fileInfo = await cacheManager.getFileFromCache(
       tileKey,
    );

    Uint8List tileBytes;
    if (fileInfo != null && fileInfo.file.existsSync()) {
      tileBytes = await fileInfo.file.readAsBytes();
    } else {
      // Si no está en caché, descarga la imagen y guárdala en caché
      final url =
          "https://tilecache.rainviewer.com/v2/radar/$timeStamps/256/$zoom/$x/$y/2/1_0.png";
      final uri = Uri.parse(url);
      final ByteData imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
      await cacheManager.putFile(
        'https://tilecache.rainviewer.com/v2/radar/$timeStamps/256/$zoom/$x/$y/2/1_0.png',
        tileBytes,
        key: tileKey,
      );
    }

    return Tile(256, 256, tileBytes);
  }
}

class TilesCache {
  static Map<String, Uint8List> tiles = {};
}
