import 'package:furnitureshop_appadmin/data/models/guarantee.dart';
import 'package:furnitureshop_appadmin/data/servers/guarantee_api_server.dart';

class GuaranteeRepository {
  GuaranteeAPIServer guaranteeAPIServer = GuaranteeAPIServer();

  Future<void> addGuarantee(Guarantee guarantee) async {
    Map<String, dynamic> data = guarantee.toMap();
    await guaranteeAPIServer.add(data);
  }
}
