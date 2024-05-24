import 'dart:convert';

import 'package:flutter/foundation.dart';

class ViatorDestinationModel {
  String? errorReference;
  List<dynamic>? data;
  DateTime dateStamp;
  String? errorType;
  List<dynamic> errorCodes;
  List<dynamic>? errorMessage;
  String? errorName;
  dynamic extraObject;
  bool success;
  int totalCount;
  List<dynamic>? errorMessageText;
  String vmid;

  ViatorDestinationModel({
    this.errorReference,
    this.data,
    required this.dateStamp,
    this.errorType,
    required this.errorCodes,
    this.errorMessage,
    this.errorName,
    required this.extraObject,
    required this.success,
    required this.totalCount,
    this.errorMessageText,
    required this.vmid,
  });

  ViatorDestinationModel copyWith({
    String? errorReference,
    List<dynamic>? data,
    DateTime? dateStamp,
    String? errorType,
    List<dynamic>? errorCodes,
    List<dynamic>? errorMessage,
    String? errorName,
    dynamic? extraObject,
    bool? success,
    int? totalCount,
    List<dynamic>? errorMessageText,
    String? vmid,
  }) {
    return ViatorDestinationModel(
      errorReference: errorReference ?? this.errorReference,
      data: data ?? this.data,
      dateStamp: dateStamp ?? this.dateStamp,
      errorType: errorType ?? this.errorType,
      errorCodes: errorCodes ?? this.errorCodes,
      errorMessage: errorMessage ?? this.errorMessage,
      errorName: errorName ?? this.errorName,
      extraObject: extraObject ?? this.extraObject,
      success: success ?? this.success,
      totalCount: totalCount ?? this.totalCount,
      errorMessageText: errorMessageText ?? this.errorMessageText,
      vmid: vmid ?? this.vmid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorReference': errorReference,
      'data': data,
      'dateStamp': dateStamp.millisecondsSinceEpoch,
      'errorType': errorType,
      'errorCodes': errorCodes,
      'errorMessage': errorMessage,
      'errorName': errorName,
      'extraObject': extraObject,
      'success': success,
      'totalCount': totalCount,
      'errorMessageText': errorMessageText,
      'vmid': vmid,
    };
  }

  factory ViatorDestinationModel.fromMap(Map<String, dynamic> map) {
    return ViatorDestinationModel(
      errorReference: map['errorReference'] != null
          ? map['errorReference'] as String
          : null,
      data: map['data'] != null
          ? List<String>.from((map['data'] as List<dynamic>))
          : null,
      dateStamp: DateTime.parse(map['dateStamp'] as String),
      errorType: map['errorType'] != null ? map['errorType'] as String : null,
      errorCodes: List<dynamic>.from((map['errorCodes'] as List<dynamic>)),
      errorMessage: map['errorMessage'] != null
          ? List<dynamic>.from((map['errorMessage'] as List<dynamic>))
          : null,
      errorName: map['errorName'] != null ? map['errorName'] as String : null,
      extraObject: map['extraObject'] as dynamic,
      success: map['success'] as bool,
      totalCount: map['totalCount'] as int,
      errorMessageText: map['errorMessageText'] != null
          ? List<dynamic>.from((map['errorMessageText'] as List<dynamic>))
          : null,
      vmid: map['vmid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ViatorDestinationModel.fromJson(String source) =>
      ViatorDestinationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ViatorDestinationModel(errorReference: $errorReference, data: $data, dateStamp: $dateStamp, errorType: $errorType, errorCodes: $errorCodes, errorMessage: $errorMessage, errorName: $errorName, extraObject: $extraObject, success: $success, totalCount: $totalCount, errorMessageText: $errorMessageText, vmid: $vmid)';
  }

  @override
  bool operator ==(covariant ViatorDestinationModel other) {
    if (identical(this, other)) return true;

    return other.errorReference == errorReference &&
        listEquals(other.data, data) &&
        other.dateStamp == dateStamp &&
        other.errorType == errorType &&
        listEquals(other.errorCodes, errorCodes) &&
        listEquals(other.errorMessage, errorMessage) &&
        other.errorName == errorName &&
        other.extraObject == extraObject &&
        other.success == success &&
        other.totalCount == totalCount &&
        listEquals(other.errorMessageText, errorMessageText) &&
        other.vmid == vmid;
  }

  @override
  int get hashCode {
    return errorReference.hashCode ^
        data.hashCode ^
        dateStamp.hashCode ^
        errorType.hashCode ^
        errorCodes.hashCode ^
        errorMessage.hashCode ^
        errorName.hashCode ^
        extraObject.hashCode ^
        success.hashCode ^
        totalCount.hashCode ^
        errorMessageText.hashCode ^
        vmid.hashCode;
  }
}
