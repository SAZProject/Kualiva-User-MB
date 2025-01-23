import 'package:kualiva/report/model/language_explain_model.dart';
import 'package:kualiva/report/model/parameter_detail_model.dart';
import 'package:kualiva/report/model/parameter_model.dart';

class ReportFaker {
  static ParameterModel getPlaceReasons() {
    List<Map<dynamic, String>> details = [
      {'en': 'Outlet closed / moved', 'id': 'Tempat tutup / pindah'},
      {'en': 'Photos do not match', 'id': 'Photo tidak sesuai'},
      {'en': 'Photos are disturbing', 'id': 'Photo tidak nyaman'},
      {'en': 'Selling drugs', 'id': 'Menjual obat terlarang'},
      {'en': 'Others', 'id': 'Lainnya'},
    ];

    final parameterDetailModels = List<ParameterDetailModel>.empty();

    for (int i = 0; i < details.length; i++) {
      parameterDetailModels.add(
        ParameterDetailModel(
          parameterId: 1,
          code: 'FNB001',
          sequence: i,
          languageCode: 'FNB001$i',
          isActive: true,
          explain: details[i]['en'] as String,
          language: LanguageExplainModel(
            languageCode: 'FNB001$i',
            en: details[i]['en'],
            id: details[i]['id'],
          ),
        ),
      );
    }
    return ParameterModel(
      id: 1,
      bizCode: 'FNB',
      languageCode: 'FNB001',
      explain: '',
      language: LanguageExplainModel(
        languageCode: 'FNB001',
        en: 'Report Place / Merchant Fnb',
        id: 'Pelaporan Place / Merchant Fnb',
      ),
      parameterDetails: parameterDetailModels,
    );
  }
}
