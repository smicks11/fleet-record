import 'dart:convert';

VehiclePayload vehiclePayloadFromJson(String str) => VehiclePayload.fromJson(json.decode(str));

String vehiclePayloadToJson(VehiclePayload data) => json.encode(data.toJson());

class VehiclePayload {
    int? code;
    bool? success;
    String? message;
    Data? data;

    VehiclePayload({
        this.code,
        this.success,
        this.message,
        this.data,
    });

    factory VehiclePayload.fromJson(Map<String, dynamic> json) => VehiclePayload(
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
    List<Vehicle>? vehicles;
    bool? nextPage;
    int? page;
    int? pageSize;

    Data({
        this.vehicles,
        this.nextPage,
        this.page,
        this.pageSize,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        vehicles: json["vehicles"] == null ? [] : List<Vehicle>.from(json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
        nextPage: json["next_page"],
        page: json["page"],
        pageSize: json["page_size"],
    );

    Map<String, dynamic> toJson() => {
        "vehicles": vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
        "next_page": nextPage,
        "page": page,
        "page_size": pageSize,
    };
}

class Vehicle {
    String? assetCode;
    String? tyreType;
    dynamic batterySize;
    String? regNumber;
    String? batteryType;
    List<String>? images;
    String? id;
    String? vehicleCategory;
    int? tankCapacity;
    bool? available;
    DateTime? dateOfPurchase;
    String? vehicleStatus;
    String? vehicleBrandId;
    int? costOfPurchase;
    String? maintenanceGarage;
    String? teamId;
    DateTime? createdAt;
    int? netBookValue;
    String? fuelType;
    DateTime? updatedAt;
    String? parkingBranch;
    String? vehicleModel;
    String? driverId;
    int? pkid;
    String? vehicleType;
    dynamic tyreSize;
    Brand? brand;
    Team? team;
    Driver? driver;

    Vehicle({
        this.assetCode,
        this.tyreType,
        this.batterySize,
        this.regNumber,
        this.batteryType,
        this.images,
        this.id,
        this.vehicleCategory,
        this.tankCapacity,
        this.available,
        this.dateOfPurchase,
        this.vehicleStatus,
        this.vehicleBrandId,
        this.costOfPurchase,
        this.maintenanceGarage,
        this.teamId,
        this.createdAt,
        this.netBookValue,
        this.fuelType,
        this.updatedAt,
        this.parkingBranch,
        this.vehicleModel,
        this.driverId,
        this.pkid,
        this.vehicleType,
        this.tyreSize,
        this.brand,
        this.team,
        this.driver,
    });

    factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        assetCode: json["asset_code"],
        tyreType: json["tyre_type"],
        batterySize: json["battery_size"],
        regNumber: json["reg_number"],
        batteryType: json["battery_type"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        id: json["id"],
        vehicleCategory: json["vehicle_category"],
        tankCapacity: json["tank_capacity"],
        available: json["available"],
        dateOfPurchase: json["date_of_purchase"] == null ? null : DateTime.parse(json["date_of_purchase"]),
        vehicleStatus: json["vehicle_status"],
        vehicleBrandId: json["vehicle_brand_id"],
        costOfPurchase: json["cost_of_purchase"],
        maintenanceGarage: json["maintenance_garage"],
        teamId: json["team_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        netBookValue: json["net_book_value"],
        fuelType: json["fuel_type"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        parkingBranch: json["parking_branch"],
        vehicleModel: json["vehicle_model"],
        driverId: json["driver_id"],
        pkid: json["pkid"],
        vehicleType: json["vehicle_type"],
        tyreSize: json["tyre_size"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        team: json["team"] == null ? null : Team.fromJson(json["team"]),
        driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    );

    Map<String, dynamic> toJson() => {
        "asset_code": assetCode,
        "tyre_type": tyreType,
        "battery_size": batterySize,
        "reg_number": regNumber,
        "battery_type": batteryType,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "id": id,
        "vehicle_category": vehicleCategory,
        "tank_capacity": tankCapacity,
        "available": available,
        "date_of_purchase": "${dateOfPurchase!.year.toString().padLeft(4, '0')}-${dateOfPurchase!.month.toString().padLeft(2, '0')}-${dateOfPurchase!.day.toString().padLeft(2, '0')}",
        "vehicle_status": vehicleStatus,
        "vehicle_brand_id": vehicleBrandId,
        "cost_of_purchase": costOfPurchase,
        "maintenance_garage": maintenanceGarage,
        "team_id": teamId,
        "created_at": createdAt?.toIso8601String(),
        "net_book_value": netBookValue,
        "fuel_type": fuelType,
        "updated_at": updatedAt?.toIso8601String(),
        "parking_branch": parkingBranch,
        "vehicle_model": vehicleModel,
        "driver_id": driverId,
        "pkid": pkid,
        "vehicle_type": vehicleType,
        "tyre_size": tyreSize,
        "brand": brand?.toJson(),
        "team": team?.toJson(),
        "driver": driver?.toJson(),
    };
}

class Brand {
    DateTime? createdAt;
    DateTime? updatedAt;
    String? name;
    int? pkid;
    String? id;
    String? description;

    Brand({
        this.createdAt,
        this.updatedAt,
        this.name,
        this.pkid,
        this.id,
        this.description,
    });

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        name: json["name"],
        pkid: json["pkid"],
        id: json["id"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "pkid": pkid,
        "id": id,
        "description": description,
    };
}

class Driver {
    int? pkid;
    String? id;
    String? driverId;
    DateTime? dateEmployed;
    String? serviceProvider;
    dynamic salary;
    DateTime? updatedAt;
    DateTime? createdAt;
    String? name;
    String? phoneNumber;
    int? level;
    bool? available;

    Driver({
        this.pkid,
        this.id,
        this.driverId,
        this.dateEmployed,
        this.serviceProvider,
        this.salary,
        this.updatedAt,
        this.createdAt,
        this.name,
        this.phoneNumber,
        this.level,
        this.available,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        pkid: json["pkid"],
        id: json["id"],
        driverId: json["driver_id"],
        dateEmployed: json["date_employed"] == null ? null : DateTime.parse(json["date_employed"]),
        serviceProvider: json["service_provider"],
        salary: json["salary"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        name: json["name"],
        phoneNumber: json["phone_number"],
        level: json["level"],
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "pkid": pkid,
        "id": id,
        "driver_id": driverId,
        "date_employed": "${dateEmployed!.year.toString().padLeft(4, '0')}-${dateEmployed!.month.toString().padLeft(2, '0')}-${dateEmployed!.day.toString().padLeft(2, '0')}",
        "service_provider": serviceProvider,
        "salary": salary,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "phone_number": phoneNumber,
        "level": level,
        "available": available,
    };
}

class Team {
    String? id;
    int? pkid;
    String? division;
    String? unit;
    String? pcCode;
    dynamic teamEmail;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? className;
    String? group;
    String? teamBranch;
    String? region;

    Team({
        this.id,
        this.pkid,
        this.division,
        this.unit,
        this.pcCode,
        this.teamEmail,
        this.createdAt,
        this.updatedAt,
        this.className,
        this.group,
        this.teamBranch,
        this.region,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        pkid: json["pkid"],
        division: json["division"],
        unit: json["unit"],
        pcCode: json["pc_code"],
        teamEmail: json["team_email"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        className: json["class_name"],
        group: json["group"],
        teamBranch: json["team_branch"],
        region: json["region"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pkid": pkid,
        "division": division,
        "unit": unit,
        "pc_code": pcCode,
        "team_email": teamEmail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "class_name": className,
        "group": group,
        "team_branch": teamBranch,
        "region": region,
    };
}
