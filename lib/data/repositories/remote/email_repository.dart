import 'package:steuermachen/constants/strings/email_constants.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';

class EmailRepository {
  Future<dynamic> sendMail(String to, String subject, String template,
      {String? message,
      String? salutation,
      String? lastName,
      String? orderNumber,
      String? orderDate,
      String? orderFrom,
      String? firstName,
      String? street,
      String? houseNumber,
      String? postcode,
      String? city,
      String? email,
      String? phone,
      String? maritalStatus,
      String? taxYear,
      String? invoiceTemplate,
      bool sendInvoice = true}) async {
    serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
        HTTPConstants.baseUrl;
    serviceLocatorInstance<DioClientNetwork>()
            .dio
            .options
            .headers["Authorization"] =
        "Bearer " + HTTPConstants.defaultAccessToken;
    var response = await serviceLocatorInstance<DioApiServices>()
        .getRequest(HTTPConstants.sendMail, queryParameters: {
      "to": to,
      "subject": subject,
      "message": message,
      "template": template,
      "salutation": salutation,
      "last_name": lastName,
      "order_number": orderNumber,
      "order_date": orderDate,
      "order_from": orderFrom,
      "first_name": firstName,
      "street": street,
      "house_number": houseNumber,
      "postcode": postcode,
      "city": city,
      "email": email,
      "phone": phone,
      "marital_status": maritalStatus,
      "tax_year": taxYear,
    });
    if (sendInvoice) {
      await invoicesMail(
          to, EmailInvoiceConstants.invoiceSubject, invoiceTemplate!,
          salutation: salutation,
          lastName: lastName,
          orderNumber: orderNumber,
          orderDate: orderDate,
          orderFrom: orderFrom,
          firstName: firstName,
          street: street,
          houseNumber: houseNumber,
          postcode: postcode,
          city: city,
          email: email,
          phone: phone,
          maritalStatus: maritalStatus,
          taxYear: taxYear);
    }
    print(response);
  }

  Future<dynamic> invoicesMail(
    String to,
    String subject,
    String template, {
    String? message,
    String? salutation,
    String? lastName,
    String? orderNumber,
    String? orderDate,
    String? orderFrom,
    String? firstName,
    String? street,
    String? houseNumber,
    String? postcode,
    String? city,
    String? email,
    String? phone,
    String? maritalStatus,
    String? taxYear,
  }) async {
    serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
        HTTPConstants.baseUrl;
    serviceLocatorInstance<DioClientNetwork>()
            .dio
            .options
            .headers["Authorization"] =
        "Bearer " + HTTPConstants.defaultAccessToken;
    var response = await serviceLocatorInstance<DioApiServices>()
        .getRequest(HTTPConstants.sendMail, queryParameters: {
      "to": to,
      "subject": "$subject $orderNumber",
      "message": message,
      "template": template,
      "salutation": salutation,
      "last_name": lastName,
      "invoice_number": orderNumber,
      "order_date": orderDate,
      "order_from": orderFrom,
      "first_name": firstName,
      "street": street,
      "house_number": houseNumber,
      "postcode": postcode,
      "city": city,
      "email": email,
      "phone": phone,
      "marital_status": maritalStatus,
      "tax_year": taxYear,
    });
    print(response);
  }
}
