import 'dart:io';
import 'dart:typed_data';

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NetworkClient extends HttpOverrides {
  final http.Client client;

  NetworkClient({required this.client});

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/tmdb.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());
    return securityContext;
  }

  @override
  HttpClient createHttpClient(SecurityContext? securityContext) {
    return HttpClient(
      context: securityContext
    )..badCertificateCallback = (_, __, ___) => false;
  }
}
