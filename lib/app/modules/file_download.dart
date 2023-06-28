import 'dart:io';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter/material.dart';
class FileDownload extends StatefulWidget {
  const FileDownload({Key key}) : super(key: key);

  @override
  State<FileDownload> createState() => _FileDownloadState();
}

class _FileDownloadState extends State<FileDownload> {
  @override
Future <dynamic> files()
        async {
    FileDownloader.downloadFile(
        url: "https://tinypng.com/images/social/website.jpg",
        name: "PANDA",
        onDownloadCompleted: (url) {
          final File file = File(url);
        });
    final List<File> result = await FileDownloader.downloadFiles(
        urls: [
          'https://cdn.mos.cms.futurecdn.net/vChK6pTy3vN3KbYZ7UU7k3-320-80.jpg',
          'https://fansided.com/files/2015/10/cat.jpg',
        ],
        isParallel: false);

    print('FILES: ${result.map((e) => e?.path).join(',\n')}');
  }


  Widget build(BuildContext context) {

      return MaterialApp(
        locale: Locale('ar'),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter file downloader example'),
          ),
          body:Container(
            child: Center(child: InkWell(
                onTap: () async{

                  final List<File> result = await FileDownloader.downloadFiles(
                      urls: [
                        'https://cdn.mos.cms.futurecdn.net/vChK6pTy3vN3KbYZ7UU7k3-320-80.jpg',
                        'https://fansided.com/files/2015/10/cat.jpg',
                      ],
                      isParallel: false);
                  print('FILES: ${result.map((e) => e?.path).join(',\n')}');


                },
                child: Text("Welcome")))
          ),

        ),
      );

  }
}

