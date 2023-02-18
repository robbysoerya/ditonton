import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class NetworkClient extends IOClient {
  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/tmdb.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

    return securityContext;
  }

  Future<IOClient> get client async {
    return IOClient(
      HttpClient(context: await globalContext)
        ..badCertificateCallback = (cert, host, port) => false,
    );
  }
}
