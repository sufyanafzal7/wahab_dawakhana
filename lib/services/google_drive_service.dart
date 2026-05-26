import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

class GoogleDriveHttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleDriveHttpClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

class GoogleDriveService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveFileScope],
  );

  Future<bool> uploadBackup(String jsonRawData) async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return false;

      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleDriveHttpClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      // Convert raw data into a byte stream for Google Drive transmission
      final List<int> bytes = utf8.encode(jsonRawData);
      final mediaStream = Stream.value(bytes);

      // Fixed: Use drive.Media to wrap your stream data package cleanly
      final media = drive.Media(
        mediaStream,
        bytes.length,
        contentType: 'application/json',
      );

      final drive.File fileMetadata = drive.File()
        ..name = 'wahab_dawakhana_cloud_backup.json'
        ..parents = ['root'];

      // Pass the media object directly as a named argument parameter
      await driveApi.files.create(
        fileMetadata,
        uploadMedia: media,
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}