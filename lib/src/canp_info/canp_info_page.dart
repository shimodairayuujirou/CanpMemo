import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampInfoPage extends StatefulWidget {
  const CampInfoPage({Key? key}) : super(key: key);

  @override
  _CampInfoPageState createState() => _CampInfoPageState();
}

class _CampInfoPageState extends State<CampInfoPage> {
  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 251, 244),
      appBar: AppBar(
        title: Text(
          'キャンプマップ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff3D6E55),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 227, 191, 32),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onCameraMove: (CameraPosition position) {
          // カメラが移動したら新しい範囲のキャンプ場情報を取得
          _getCampgroundData(position.target);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(35.6895, 139.6917),
          zoom: 10.0,
        ),
        markers: _markers,
      ),
    );
  }

  Future<void> _getCampgroundData(LatLng center) async {
    // Google Maps Places API キーが必要です
    final apiKey = 'AIzaSyBEQQW_g2ateavm949tlz9ZXGit70WGpNo';
    // Places API からキャンプ場の情報を取得
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=campground&key=$apiKey&location=${center.latitude},${center.longitude}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];

      // 既存のマーカーをクリア
      setState(() {
        _markers.clear();
      });

      for (final result in results) {
        final location = result['geometry']['location'];
        final marker = Marker(
          markerId: MarkerId('${location['lat']}-${location['lng']}'),
          position: LatLng(location['lat'], location['lng']),
          infoWindow: InfoWindow(
            title: result['name'],
            snippet: result['formatted_address'],
            onTap: () {
              // マーカーがタップされたときの処理
              _showCampgroundDetails(result, context); // 詳細情報を表示するメソッドを呼び出す
            },
          ),
        );
        setState(() {
          _markers.add(marker);
        });
      }
    } else {
      print('Failed to load campground data');
    }
  }
}
void _showCampgroundDetails(Map<String, dynamic> campground, context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      // サンプル写真のURLリスト
      List<String> samplePhotos = [
        'https://example.com/photo1.jpg',
        'https://example.com/photo2.jpg',
        'https://example.com/photo3.jpg',
      ];

      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              campground['name'],
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '住所: ${campground['formatted_address']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // 写真を表示するウィジェット
            campPhotosWidget(samplePhotos),
            SizedBox(height: 16.0),

            // 星のレビューを表示するウィジェット
            starRatingWidget(4.5), // 仮の評価

            // その他の情報やボタンなどを追加
          ],
        ),
      );
    },
  );
}

Widget campPhotosWidget(List<String> photos) {
  if (photos == null || photos.isEmpty) {
    return SizedBox.shrink();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '写真:',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8.0),
      Container(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Image.network(
                photos[index],
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget starRatingWidget(double rating) {
  if (rating == null) {
    return SizedBox.shrink();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '評価:',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8.0),
      // 実際の星のレビューウィジェットを追加することが好ましいですが、仮でテキスト表示しています
      Text(
        '$rating / 5.0',
        style: TextStyle(fontSize: 16.0),
      ),
    ],
  );
}
