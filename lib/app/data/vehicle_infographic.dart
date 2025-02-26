import 'dart:convert';

VehicleInfographic vehicleInfographicFromJson(String str) => VehicleInfographic.fromJson(json.decode(str));

String vehicleInfographicToJson(VehicleInfographic data) => json.encode(data.toJson());

class VehicleInfographic {
    int? code;
    bool? success;
    String? message;
    Data? data;

    VehicleInfographic({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory VehicleInfographic.fromJson(Map<String, dynamic> json) => VehicleInfographic(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? totalVehicles;
    int? availableVehicles;
    int? unavailableVehicles;
    List<VehiclesByBrand>? vehiclesByBrand;

    Data({
        this.totalVehicles,
        this.availableVehicles,
        this.unavailableVehicles,
        this.vehiclesByBrand,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalVehicles: json["total_vehicles"],
        availableVehicles: json["available_vehicles"],
        unavailableVehicles: json["unavailable_vehicles"],
        vehiclesByBrand: json["vehicles_by_brand"] == null ? [] : List<VehiclesByBrand>.from(json["vehicles_by_brand"]!.map((x) => VehiclesByBrand.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_vehicles": totalVehicles,
        "available_vehicles": availableVehicles,
        "unavailable_vehicles": unavailableVehicles,
        "vehicles_by_brand": vehiclesByBrand == null ? [] : List<dynamic>.from(vehiclesByBrand!.map((x) => x.toJson())),
    };
}

class VehiclesByBrand {
    String? brand;
    int? totalVehicles;

    VehiclesByBrand({
        this.brand,
        this.totalVehicles,
    });

    factory VehiclesByBrand.fromJson(Map<String, dynamic> json) => VehiclesByBrand(
        brand: json["brand"],
        totalVehicles: json["total_vehicles"],
    );

    Map<String, dynamic> toJson() => {
        "brand": brand,
        "total_vehicles": totalVehicles,
    };
}
