import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/app_enums.dart';
import 'common_fun.dart';

class FileDownloader {
  static Future<void> downloadFile(BuildContext context, String url) async {
    if (url.isEmpty) {
      showToast('رابط الملف غير صالح', state: ToastStates.error);
      return;
    }

    showToast('جاري بدء التحميل...', state: ToastStates.info);

    try {
      bool hasPermission = true;
      if (Platform.isAndroid) {
        final status = await Permission.storage.status;
        if (!status.isGranted) {
          final result = await Permission.storage.request();
          hasPermission = result.isGranted;
        }
      }

      Directory? directory;
      if (Platform.isAndroid && hasPermission) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      directory ??= await getTemporaryDirectory();

      final uri = Uri.parse(url);
      String fileName = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'downloaded_file';
      
      if (!fileName.contains('.')) {
        fileName = '$fileName.jpg';
      }

      final savePath = '${directory.path}/$fileName';

      final dio = Dio();
      await dio.download(
        url,
        savePath,
      );

      showToast('تم تحميل الملف بنجاح', state: ToastStates.success);
    } catch (e) {
      debugPrint('Error downloading file: $e');
      showToast('حدث خطأ أثناء تحميل الملف', state: ToastStates.error);
    }
  }
}
