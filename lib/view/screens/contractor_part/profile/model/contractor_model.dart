class ContractorModel {
    bool? success;
    String? message;
    Data? data;

    ContractorModel({
        this.success,
        this.message,
        this.data,
    });

    factory ContractorModel.fromJson(Map<String, dynamic> json) => ContractorModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? fullName;
    String? email;
    String? contactNo;
    bool? otpVerified;
    String? img;
    String? role;
    String? status;
    String? adminAccept;
    bool? isDeleted;
    num? profileCompletion;
    DateTime? passwordChangedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Contractor? contractor;

    Data({
        this.id,
        this.fullName,
        this.email,
        this.contactNo,
        this.otpVerified,
        this.img,
        this.role,
        this.status,
        this.adminAccept,
        this.isDeleted,
        this.profileCompletion,
        this.passwordChangedAt,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.contractor,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        contactNo: json["contactNo"],
        otpVerified: json["otpVerified"],
        img: json["img"],
        role: json["role"],
        status: json["status"],
        adminAccept: json["adminAccept"],
        isDeleted: json["isDeleted"],
        profileCompletion: json["profileCompletion"],
        passwordChangedAt: json["passwordChangedAt"] == null
            ? null
            : DateTime.parse(json["passwordChangedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        contractor: json["contractor"] == null
            ? null
            : Contractor.fromJson(json["contractor"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "contactNo": contactNo,
        "otpVerified": otpVerified,
        "img": img,
        "role": role,
        "status": status,
        "adminAccept": adminAccept,
        "isDeleted": isDeleted,
        "profileCompletion": profileCompletion,
        "passwordChangedAt": passwordChangedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "contractor": contractor?.toJson(),
    };
}

class Contractor {
    String? id;
    String? dob;
    String? gender;
    String? experience;
    String? bio;
    String? city;
    String? language;
    String? location;
    num? rateHourly;
    num? balance;
    String? skillsCategory;
    num? ratings;
    String? subscriptionStatus;
    String? customerId;
    String? paymentMethodId;
    List<String>? certificates;
    MyScheduleId? myScheduleId;
    bool? isDeleted;
    List<String>? skills;
    List<String>? subCategory;
    List<Material>? materials;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? userId;
    String? category;
    dynamic subscriptionId;
    bool? hasActiveSubscription;

    Contractor({
        this.id,
        this.dob,
        this.gender,
        this.experience,
        this.bio,
        this.city,
        this.language,
        this.location,
        this.rateHourly,
        this.balance,
        this.skillsCategory,
        this.ratings,
        this.subscriptionStatus,
        this.customerId,
        this.paymentMethodId,
        this.certificates,
        this.myScheduleId,
        this.isDeleted,
        this.skills,
        this.subCategory,
        this.materials,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.userId,
        this.category,
        this.subscriptionId,
        this.hasActiveSubscription,
    });

    factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        id: json["_id"],
        dob: json["dob"],
        gender: json["gender"],
        experience: json["experience"],
        bio: json["bio"],
        city: json["city"],
        language: json["language"],
        location: json["location"],
        rateHourly: json["rateHourly"],
        balance: json["balance"],
        skillsCategory: json["skillsCategory"],
        ratings: json["ratings"],
        subscriptionStatus: json["subscriptionStatus"],
        customerId: json["customerId"],
        paymentMethodId: json["paymentMethodId"],
        certificates: json["certificates"] == null
            ? []
            : List<String>.from(json["certificates"].map((x) => x)),
        myScheduleId: json["myScheduleId"] == null
            ? null
            : MyScheduleId.fromJson(json["myScheduleId"]),
        isDeleted: json["isDeleted"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"].map((x) => x)),
        subCategory: json["subCategory"] == null
            ? []
            : List<String>.from(json["subCategory"].map((x) => x)),
        materials: json["materials"] == null
            ? []
            : List<Material>.from(
            json["materials"].map((x) => Material.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userId: json["userId"],
        category: json["category"],
        subscriptionId: json["subscriptionId"],
        hasActiveSubscription: json["hasActiveSubscription"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "dob": dob,
        "gender": gender,
        "experience": experience,
        "bio": bio,
        "city": city,
        "language": language,
        "location": location,
        "rateHourly": rateHourly,
        "balance": balance,
        "skillsCategory": skillsCategory,
        "ratings": ratings,
        "subscriptionStatus": subscriptionStatus,
        "customerId": customerId,
        "paymentMethodId": paymentMethodId,
        "certificates": certificates ?? [],
        "myScheduleId": myScheduleId?.toJson(),
        "isDeleted": isDeleted,
        "skills": skills ?? [],
        "subCategory": subCategory ?? [],
        "materials": materials?.map((x) => x.toJson()).toList() ?? [],
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "userId": userId,
        "category": category,
        "subscriptionId": subscriptionId,
        "hasActiveSubscription": hasActiveSubscription,
    };
}

class Material {
    String? name;
    String? unit;
    num? price;
    String? id;

    Material({
        this.name,
        this.unit,
        this.price,
        this.id,
    });

    factory Material.fromJson(Map<String, dynamic> json) => Material(
        name: json["name"],
        unit: json["unit"],
        price: json["price"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "unit": unit,
        "price": price,
        "_id": id,
    };
}

class MyScheduleId {
    String? id;
    String? contractorId;
    List<Schedule>? schedules;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    MyScheduleId({
        this.id,
        this.contractorId,
        this.schedules,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory MyScheduleId.fromJson(Map<String, dynamic> json) => MyScheduleId(
        id: json["_id"],
        contractorId: json["contractorId"],
        schedules: json["schedules"] == null
            ? []
            : List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "contractorId": contractorId,
        "schedules": schedules?.map((x) => x.toJson()).toList() ?? [],
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Schedule {
    String? days;
    List<String>? timeSlots;
    String? id;

    Schedule({
        this.days,
        this.timeSlots,
        this.id,
    });

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        days: json["days"],
        timeSlots: json["timeSlots"] == null
            ? []
            : List<String>.from(json["timeSlots"].map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "days": days,
        "timeSlots": timeSlots ?? [],
        "_id": id,
    };
}
