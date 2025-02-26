import 'dart:convert';

LoginPayload loginPayloadFromJson(String str) => LoginPayload.fromJson(json.decode(str));

String loginPayloadToJson(LoginPayload data) => json.encode(data.toJson());

class LoginPayload {
    bool? success;
    int? code;
    String? message;
    Data? data;

    LoginPayload({
        this.success,
        this.code,
        this.message,
        this.data,
    });

    factory LoginPayload.fromJson(Map<String, dynamic> json) => LoginPayload(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? accessToken;
    String? refreshToken;
    int? accessTokenExpires;
    int? refreshTokenExpires;
    String? adminId;

    Data({
        this.accessToken,
        this.refreshToken,
        this.accessTokenExpires,
        this.refreshTokenExpires,
        this.adminId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        accessTokenExpires: json["access_token_expires"],
        refreshTokenExpires: json["refresh_token_expires"],
        adminId: json["admin_id"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "access_token_expires": accessTokenExpires,
        "refresh_token_expires": refreshTokenExpires,
        "admin_id": adminId,
    };
}
