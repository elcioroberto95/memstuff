import 'date_helper.dart';

const kRequiredField = 'Campo obrigatório';
const kInvalidPhone = 'Telefone inválido';
const kInvalidDate = 'Data inválida';

class ValidatorHelper {
  static String checkValidation(String text) {
    if (text.isEmpty)
      return kRequiredField;
    else
      return null;
  }

  static String checkPhone(String text) {
    if (text.isEmpty)
      return kRequiredField;
    else if (text.length != 13 && text.length != 14)
      return kInvalidPhone;
    else
      return null;
  }

  static String checkDate(String text) {
    var date = DateHelper.parse(text);
    var today = DateTime.now();

    if (date.isAfter(today))
      return kInvalidDate;
    else
      return null;
  }
}
