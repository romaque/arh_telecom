library utils.env;

String urlApi = "https://site.envoysistemas.com.br/";

String numberMask(text) {
  return text.replaceAll(new RegExp(r'[^0-9]'), '');
}
