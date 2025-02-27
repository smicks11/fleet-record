import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fleet_app/app/modules/car_portal/controllers/car_portal_controller.dart';
import 'package:fleet_app/app/modules/car_portal/views/components/search.dart';
import 'package:fleet_app/app/shared/app_util.dart';
import 'package:fleet_app/app/shared/assets.dart';
import 'package:fleet_app/app/shared/form_validators.dart';
import 'package:fleet_app/app/shared/size.dart';
import 'package:fleet_app/app/shared/text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:cross_file/cross_file.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';

class AddCarDialog extends StatefulWidget {
  const AddCarDialog({super.key});

  @override
  _AddCarDialogState createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<AddCarDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController carNameController = TextEditingController();
  final carController = Get.find<CarPortalController>();

  // String? selectedVehicleType;
  // String? selectedFuelType;
  // String? selectedAvailability;
  // String? selectedMileage;

  // final List<String> fuelTypes = ["Petrol", "Diesel", "Electric", "Hybrid"];
  // final List<String> availabilityOptions = ["Available", "Unavailable"];
  // final List<String> mileageOptions = ["0-10k", "10k-50k", "50k+"];

  // List<dynamic> _pickedImages = [];

  // Future<void> pickImages() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //     withData: kIsWeb,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _pickedImages = result.files.map((file) {
  //         if (kIsWeb) {
  //           return file.bytes;
  //         } else {
  //           return File(file.path!);
  //         }
  //       }).toList();
  //     });
  //   }
  // }
  List<dynamic> _pickedImages = List.filled(4, null, growable: true);

  Future<void> pickImageFor(int index) async {
    final ImagePickerPlugin picker = ImagePickerPlugin();

    final XFile? pickedFile =
        await picker.getImageFromSource(source: ImageSource.gallery);

    if (pickedFile != null) {
      dynamic imageData;

      if (kIsWeb) {
        imageData = await pickedFile.readAsBytes();
      } else {
        imageData = pickedFile.path;
      }

      setState(() {
        _pickedImages[index] = imageData;
      });
    }
  }

  // Future<void> pickImageFor(int index) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: false,
  //     withData: kIsWeb,
  //     // withReadStream: kIsWeb
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _pickedImages[index] =
  //           kIsWeb ? result.files.first.bytes : File(result.files.first.path!);
  //     });
  //   }
  // }

  void removeImageIndex(int index) {
    setState(() {
      _pickedImages[index] = null;
    });
  }

  Uint8List? _pickedImage;

  Future<void> pickImage() async {
    final ImagePickerPlugin picker = ImagePickerPlugin();

    final XFile? pickedFile =
        await picker.getImageFromSource(source: ImageSource.gallery);

    if (pickedFile != null) {
      dynamic imageData;

      if (kIsWeb) {
        imageData = await pickedFile.readAsBytes();
      } else {
        imageData = pickedFile.path;
      }

      setState(() {
        _pickedImage = imageData;
      });
    }
  }

  // Future<void> pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     withData: kIsWeb,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _pickedImage = result.files.first.bytes;
  //     });
  //   }
  // }

  void removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  // Controllers for text fields
  final TextEditingController assetCodeController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController dateOfPurchaseController =
      TextEditingController();
  final TextEditingController costOfPurchaseController =
      TextEditingController();
  final TextEditingController netBookValueController = TextEditingController();
  final TextEditingController tankCapacityController = TextEditingController();

// Variables for dropdown selections
  String? vehicleCategory;
  String? parkingBranch;
  String? vehicleBrand;
  String? vehicleModel;
  String? vehicleType;
  String? tyreType;
  String? tyreSize;
  String? batteryType;
  String? batterySize;
  String? vehicleStatus;
  String? maintenanceGarage;

  // Controllers
  final TextEditingController pcCodeController = TextEditingController();
  final TextEditingController teamEmailController = TextEditingController();

// Dropdown Variables
  String? selectedClass;
  String? selectedDivision;
  String? selectedGroup;
  String? selectedUnit;
  String? selectedTeamBranch;
  String? selectedRegion;

  final List<String> classList = [
    "BACK OFFICE",
    "BUSINESS BANKING",
    "COMMERCIAL",
    "CORPORATE BANKING",
    "PUBLIC SECTOR",
    "RETAIL",
    "SME",
    "SUBSIDIARY",
    "TSD"
  ];

  final List<String> divisionList = [
    "BBD ISLAND",
    "BBD MAINLAND",
    "CBG ISLAND",
    "CBG MAINLAND",
    "CORPORATE AFFAIRS",
    "CORPORATE BANK ISLAND",
    "CORPORATE BANK MAINLAND",
    "CORPORATE SERVICES",
    "DIGITAL BANKING",
    "ENERGY BANKING",
    "ERM",
    "FINCON",
    "FINTECH GROUP",
    "FINTEL",
    "FOOD & BEVERAGES",
    "GLOBAL MARKET",
    "GT UK",
    "GTPENSION",
    "HABARI",
    "HOLDCO",
    "LEGAL GROUP",
    "NORTH EAST",
    "NORTH WEST",
    "PUBLIC SECTOR LAGOS",
    "RETAIL ABUJA 1",
    "RETAIL ABUJA 2",
    "RETAIL LAGOS ISLAND",
    "RETAIL LAGOS MAINLAND",
    "RETAIL SOUTH WEST",
    "SETTLEMENT",
    "SME ABUJA",
    "SME LAGOS ISLAND 1",
    "SME LAGOS ISLAND 2",
    "SME MAINLAND 1",
    "SME MAINLAND 2",
    "SOUTH EAST",
    "SOUTH SOUTH",
    "SOUTH WEST OTHER BUSINESS",
    "SYSCON",
    "TECHNOLOGY",
    "TSG ABUJA & N/CENTRAL",
    "TSG LAGOS & WEST",
    "TSG N/WEST & N/EAST",
    "TSG S/SOUTH & S/EAST"
  ];
  List<String> groupList = [
    "ABG",
    "ABG 1",
    "ABG 2",
    "ADMIN",
    "ADMINISTRATION",
    "AGRIC",
    "BBG",
    "BBG ISLAND",
    "BBG LAGOS ISLAND GROUP 2",
    "BBG SOUTH WEST",
    "BEVERAGES",
    "BRANCH ADMIN COORDINATOR",
    "BUSINESS BANKING GROUP",
    "CARD RISK",
    "CASH MANAGEMENT",
    "CBG",
    "CBG 1",
    "CBG 2",
    "CBG 3",
    "CBG ABUJA",
    "CBG DIVISIONAL HEAD",
    "CBG GROUP HEAD",
    "CBG NORTHWEST",
    "CEMENT",
    "CMU",
    "COMMERCIAL BANK",
    "CONSTRUCTION",
    "CORPORATE AFFAIR",
    "CORPORATE AFFAIRS",
    "CORPORATE BANK",
    "CORPORATE BANK ISLAND",
    "CORPORATE BANK MAINLAND",
    "CREDIT ADMIN",
    "DIGITAL BANKING",
    "DIV. HEAD",
    "E PAYMENT",
    "ENERGY",
    "ENERGY 2",
    "EXECUTIVE",
    "FINANCIAL INSTITUTION",
    "FINCON",
    "FINTECH",
    "FINTEL",
    "FLOURS",
    "FOOD",
    "FOOD AND BEVERAGES",
    "GH RETAIL MAINLAND 6",
    "GLOBAL MARKETS DIVISION",
    "GROUD HEAD RETAIL",
    "GROUP HEAD ABG SOUTH EAST",
    "GROUP HEAD CBG SOUTH SOUTH 4",
    "GROUP HEAD RETAIL 2",
    "GROUP HEAD SANEF",
    "GROUP HEAD SME",
    "GROUP HEAD SOUTH EAST 3",
    "GT UK",
    "GTPENSION",
    "HABARI",
    "IBG -ENERGY",
    "INTERNAL CONTROL",
    "INTERNAL CONTROL GROUP",
    "INTERNATIONAL SETTLEMENTS",
    "LAGOS MAINLAND 3",
    "LEGAL GROUP",
    "MARITIME",
    "METALS",
    "MICR",
    "MID STREAM 1",
    "MULTILATERAL",
    "NDANI TV",
    "OIL MAJORS 3",
    "PLATINUM",
    "PLATINUM PLUS",
    "PROTOCOL",
    "PSG ISLAND",
    "PUBLIC SECTOR",
    "PUBLIC SECTOR ABUJA",
    "RESOURCE SHARING",
    "RETAIL",
    "RETAIL 1",
    "RETAIL 2",
    "RETAIL 3",
    "RETAIL ABUJA",
    "RETAIL ABUJA 1",
    "RETAIL ABUJA 2",
    "RETAIL AND SME",
    "RETAIL BANKING GROUP",
    "RETAIL GROUP",
    "RETAIL MAINLAND 1",
    "RETAIL NEW MARKET ROAD",
    "RETAIL SOUTH SOUTH 3",
    "RETAIL SOUTH WEST",
    "RETAIL SOUTH WEST 2",
    "RETAIL SOUTH WEST 4",
    "RETAIL SOUTH WEST 5",
    "RETAIL SOUTHWEST",
    "RETAIL SOUTHWEST 1",
    "RETAIL SOUTHWEST 2",
    "RETAIL SOUTHWEST 4",
    "RETAIL SOUTHWEST 5",
    "SECURITY",
    "SECURITY COORDINATOR",
    "SERVICE MANAGEMENT",
    "SME",
    "SME SOUTHWEST",
    "SME SOUTHWEST 1",
    "SME 1",
    "SME 1&2",
    "SME 2",
    "SME ABUJA",
    "SME ABUJA",
    "SME ABUJA 1",
    "SME ABUJA 2",
    "SME MAINLAND",
    "SME SOUTHWEST",
    "SME SOUTHWEST 1",
    "SME TRADERS",
    "SOUTH WEST",
    "SOUTH WEST 2",
    "SOUTHWEST 1",
    "SOUTHWEST 1 TSG",
    "SOUTHWEST 2",
    "SOUTHWEST 4",
    "SYSCON",
    "SYSCON",
    "SYSCON MAINLAND",
    "SYSCON SOUTHWEST",
    "TECHNOLOGY",
    "TELECOMMS",
    "TRANSACTION SERVICES ABUJA & NORTH EAST 1",
    "TRANSACTION SERVICES ABUJA & NORTH EAST 2",
    "TRANSACTION SERVICES ABUJA & NORTH EAST 3",
    "TRANSACTION SERVICES NORTH WEST, NORTH CENTRAL & NORTH EAST 2",
    "TSG",
    "TSG COORDINATOR",
    "TSG GROUP HEAD SOUTHEAST",
    "TSG ISLAND 1",
    "TSG MAINLAND",
    "TSG SOUTH WEST",
    "TSG SOUTH WEST 1",
    "UPSTREAM GROUP 2"
  ];

  List<String> unitList = [
    "ADMIN TELECOMS",
    "AGRIC BUSINESS",
    "AUTOMOBILE",
    "AVIATION",
    "BBG",
    "BEVERAGES",
    "BMP1",
    "BPM1",
    "BPM2",
    "BPM3",
    "CAD",
    "CARD AND PRODUCTS DEVELOPMENT",
    "CBG",
    "CBG 1&2",
    "CBG 2&3",
    "CBG 4",
    "CBG IKOYI 1",
    "CEMENT",
    "CENTRALIZED",
    "CMU",
    "COMMODITIES & CONGLOMERATE",
    "CORPORATE AFFAIRS",
    "CTU",
    "DANGOTE",
    "E PAYMENT",
    "E- PAYMENT PARTNERSHIP & CALLABORATIONS",
    "ENERGY MID STREAM",
    "ENERGY UPSTEAM",
    "ENERGY UPSTEAM 2",
    "ENERGY/F.I. ENERGY UPSTREAM",
    "EPAYMENT SOLUTION",
    "FI",
    "FINCON",
    "FMU",
    "FOOD",
    "FOPS",
    "GROUP HEAD BBG",
    "GROUP HEAD RETAIL LAGOS ISLAND 1",
    "GT UK",
    "GTPENSION",
    "HABARI",
    "HOLDCO",
    "LEGAL",
    "MOBILE MONEY",
    "MTN,AIRTEL & GLO",
    "NDANI",
    "PBG2",
    "PLATINUM",
    "PLATINUM / SME",
    "PLATINUM BANKING",
    "POS",
    "PSG",
    "RETAIL",
    "RETAIL",
    "RETAIL 1&2",
    "RETAIL 2 (ASOKORO, KUBWA, SANEF KARU 2)",
    "RETAIL GROUP HEAD",
    "RETAIL LOANS",
    "RETAIL PROMO",
    "SECURITY",
    "SME 1",
    "SME 2",
    "SME 3",
    "SME EDUCATION",
    "SME FOODS",
    "SME HEALTH",
    "SME PLAZA 1",
    "SME PLAZA 1&2",
    "SME SPORT AND LIFESTYLE",
    "SYSCON",
    "TECHNOLOGY",
    "TELECOMS",
    "TSG"
  ];

  List<String> regionList = [
    "ABUJA",
    "LAGOS ISLAND",
    "LAGOS MAINLAND",
    "NORTH",
    "SOUTH EAST",
    "SOUTH WEST"
  ];

// Function to calculate Net Book Value (NBV)
  void calculateNetBookValue() {
    if (costOfPurchaseController.text.isEmpty ||
        dateOfPurchaseController.text.isEmpty) {
      netBookValueController.text = "";
      return;
    }

    double? cop = double.tryParse(costOfPurchaseController.text);
    if (cop == null || cop <= 10) {
      netBookValueController.text = "";
      return;
    }

    DateTime? purchaseDate;
    try {
      purchaseDate =
          DateFormat('yyyy-MM-dd').parse(dateOfPurchaseController.text);
    } catch (e) {
      netBookValueController.text = "";
      return;
    }

    int monthsSincePurchase =
        DateTime.now().difference(purchaseDate).inDays ~/ 30;
    monthsSincePurchase = monthsSincePurchase.clamp(0, 48);

    double depreciationPerMonth = (cop - 10) / 48;
    double netBookValue = cop - (depreciationPerMonth * monthsSincePurchase);

    netBookValueController.text = netBookValue.toStringAsFixed(0);
  }

// Function to auto-fill tank capacity based on brand and model
  void updateTankCapacity() {
    Map<String, Map<String, String>> tankCapacities = {
      "Toyota": {
        "Belta": "45L",
        "Corolla": "60L",
        "Coaster": "95L",
        "Hiace": "80L",
        "Hilux": "75L",
        "Yaris": "45L",
      },
      "Honda": {
        "City": "40L",
      },
      "Nissan": {
        "Almera": "45L",
      },
      "GAC": {
        "GA3S": "50L",
      },
      "Mitsubishi": {
        "L200": "75L",
      },
    };

    if (vehicleBrand != null &&
        vehicleModel != null &&
        tankCapacities.containsKey(vehicleBrand!) &&
        tankCapacities[vehicleBrand!]!.containsKey(vehicleModel!)) {
      tankCapacityController.text =
          tankCapacities[vehicleBrand!]![vehicleModel!]!;
    } else {
      tankCapacityController.text = "";
    }
  }

  // Vehicle Categories
  final List<String> vehicleCategories = [
    "Pool",
    "Status",
    "Cash-in-transit (CIT)"
  ];

// Vehicle Brands
  final List<String> vehicleBrands = [
    "Toyota",
    "Honda",
    "Nissan",
    "GAC",
    "Ford",
    "Mitsubishi",
    "Mercedes",
    "Isuzu"
  ];

// Vehicle Models
  final List<String> vehicleModels = [
    "Almera",
    "Belta",
    "Corolla",
    "Coaster",
    "City",
    "Focus",
    "GA3S",
    "Hiace",
    "L200",
    "Benz Truck",
    "Counter Truck",
    "Isuzu Truck"
  ];

// Vehicle Types
  final List<String> vehicleTypes = ["Saloon", "SUV", "Truck", "Bus"];

// Tyre Types
  final List<String> tyreTypes = [
    "Austone",
    "Bridgestone",
    "Continental",
    "Ceat",
    "Dunlop",
    "Michelin",
    "Maxxis",
    "Prinx Premium"
  ];

// Battery Types
  final List<String> batteryTypes = [
    "Diamond",
    "Solite",
    "Everstart",
    "Inci Aku",
    "Runall",
    "Verser"
  ];

// Battery Sizes
  final List<String> batterySizes = [
    "38AMPS",
    "45AMPS",
    "55AMPS",
    "65AMPS",
    "75AMPS",
    "100AMPS",
    "150AMPS"
  ];

// Vehicle Statuses
  final List<String> vehicleStatuses = [
    "Active",
    "Inactive",
    "Grounded",
    "Disposed"
  ];

// Placeholder for Parking Branches & Maintenance Garages (to be populated from Excel)
  List<String> parkingBranches = [
    "ABDULFATAI SANNI MECHANIC",
    "ABDULKAREEM AUTO MECHANIC WORKS",
    "ABDULLAHI GARBA",
    "ABDULWAHEED ABDULRAHMAN",
    "ABIDOYE SEGUN",
    "ABIODUN MECHANIC",
    "ADENOWO MECHANICAL ENGINEERING",
    "AGBONMAGBE AUTOMOBILES AND AUTOMOTIVES LTD",
    "ALBAKA GARAGE",
    "ALI IBRAHIM ADES AUTOMOBILE",
    "AUTO OPERATING & SERVICE COMPANY",
    "AUTO POINTE QUICK FIT",
    "AUTOGIG",
    "AYOLOLA MOTORS LIMITED",
    "BAMIGBOYE ADESINA AUTO",
    "BASIRU TAMBAI MECHANIC",
    "BOGHOS MITILIAN",
    "BRAS VENTURES LIMITED",
    "CHARLES EGHAREVBA",
    "CHASTE & FRESH NIG. LTD",
    "CIG MOTORS CO. LTD",
    "COLDMAN GARAGES ENTERPRISES",
    "COOL CONCEPT AIR CONDITIONING SERVICES",
    "DAKOTELA INTERNATIONAL TECHNOLOGIES LIMITED",
    "DAN KAKMA",
    "DE BETIKS VENTURES",
    "DIONAD COMPANY LIMITED",
    "DIVERSE AUTOMOBILE VENTURES",
    "DONVIC AUTO CENTRE",
    "ELIZADE NIGERIA LIMITED",
    "EXCELLENCE ENGINEERING SERVICES",
    "FALAS AUTO MECHANICAL CONSULTANTS",
    "G. C. ONUKWUGHA",
    "GAN & GARAGE LIMITED",
    "GBENGA ADEBIYI AKANBI",
    "GBOLA MECHANIC WORKSHOP",
    "GIDAN HONDA",
    "GLOBE MOTORS",
    "GYANG C. DAVOU MOTOR",
    "HAMMED OMOTAYO AUTOMOBILE",
    "HENRY AUTO MECHANICAL",
    "I.J. NIG. ENTERPRISES",
    "IBRAHIM ABDULSALAM",
    "JAMIU ABUBAKAR",
    "JHUMLATH FUMIGATION AND CLEANING ENTERPRISES",
    "JIGWAL MOTORS",
    "JIMMY AUTOMOBILE WORKS",
    "K. E. OGUNYEMI AUTO MECHANIC",
    "KARIM TECHNICAL",
    "LANRE SHITTU MOTORS",
    "LUCKY STAR CHIGOZIE AUTO MECHANIC",
    "LUTONIAN TECHNOLOGY LIMITED",
    "MANDILAS ENTERPRISES LIMITED",
    "MAYOWA EZEKIEL",
    "MERCEDES-BENZ AUTO",
    "MOSHOOD MOSADOBA MECHANICAL ENGINEERING",
    "MOTOR MAC AUTOMOBILES",
    "MUKAILA ALABI AUTO TECH ENTERPRISES",
    "MUSA SALISU SADAM",
    "NORD AUTOMOBILE LIMITED",
    "ODEDE NOAH GBOLAHAN",
    "OGUGUO CHINEDU",
    "OKAMA SUNDAY AMEH",
    "OLA OSA AUTOMOBILE WORKS",
    "OLAYIWOLA OLUFEMI SUNDAY",
    "OYE SOLOMON ENTERPRISES",
    "PETRICHOR ORTUS NIG. LTD",
    "PILLAR OF GRACE ENGINEERING",
    "QUADRATIC AUTO SERVICES",
    "RACE LAND AUTO MECHANIC",
    "RATOS AUTOS NIGERIA LIMITED",
    "ROCK FOUNDATION AUTOMOBILE INVESTMENT LTD",
    "SESYG AUTOMOBILE MECHANIC",
    "SIKSHO AUTOMOBILE",
    "SULFRID MECHANICAL WORK",
    "SUNDAY AROWOLO AUTOMOBILE MECHANIC",
    "SUNDAY BANJOKO & CO.",
    "SUNNY NWEKE MOTOR MECHANICS",
    "TEEKOLAS KLASSIC AUTO REPAIRS LTD",
    "THE HONDA PLACE",
    "TIMOTHY AUTOMOBILE",
    "YAYA WASIU AUTO MECHANIC",
  ];

  List<String> teamBranchList = [
    "ABA",
    "ABA II",
    "ABA ROAD, PORT HARCOURT 2",
    "ABAKALIKI",
    "ABEOKUTA",
    "ABU ZARIA BRANCH",
    "ABULE EGBA 3",
    "ABULE-EGBA",
    "ADENIRAN  OGUNSANYA E-BRANCH",
    "ADENIYI JONES",
    "ADEOLA ODEKU",
    "ADETOKUNBO ADEMOLA WUSE 2",
    "ADMIRALTY",
    "ADO-EKITI",
    "AGBARA BRANCH",
    "AGBOWO IBADAN",
    "AIRPORT ROAD 2",
    "AIRPORT ROAD, WARRI",
    "AJAH",
    "AJOSE ADEOGUN",
    "AKIN ADESOLA",
    "AKOWONJO",
    "AKTH CASH CENTRE KANO",
    "AKURE",
    "AKURE E-BRANCH",
    "ALABA",
    "ALAUSA",
    "ALKALI ROAD, KADUNA",
    "ALLEN AVENUE",
    "AMUWO ODOFIN",
    "ANTHONY",
    "APAPA1 - COMMERCIAL ROAD",
    "APAPA2 CREEK ROAD",
    "APATA - IBADAN",
    "APO GUDU",
    "ARCHIVE",
    "AREA 11 GARKI - ABUJA",
    "ASABA",
    "ASABA 2",
    "ASERO-ABEOKUTA",
    "ASOKORO ABUJA",
    "ASPAMDA (TRADE FAIR)",
    "AUCHI",
    "AUN-YOLA",
    "AWKA",
    "BABCOCK BRANCH",
    "BADORE BRANCH",
    "BAUCHI",
    "BAYO KUKU",
    "BENIN CITY",
    "BENIN II - USELU",
    "BENIN III-AKPAKPAVA",
    "BENIN IV-EKENWAN BRANCH",
    "BENIN V - IKPOBA HILLS",
    "BENIN VI - EKPOMA",
    "BERGER PAINTS OBA-AKRAN",
    "BODE THOMAS II",
    "BODIJA - IBADAN",
    "BODIJA 2",
    "BONNY",
    "BRININ KEBBI",
    "BROAD STREET",
    "BUK KANO",
    "BURMA ROAD,APAPA",
    "CALABAR",
    "CALABAR 2",
    "CATHOLIC MISSION",
    "CBD ABEOKUTA",
    "CBD ABUJA",
    "CBD ALAUSA",
    "CELE IJESHA",
    "CHEVRON DRIVE",
    "COMPUTER VILLAGE",
    "COSTAIN E-BRANCH",
    "CPC",
    "DAMATURU",
    "DIYA GBAGADA",
    "DRS GBAGADA",
    "DUALLA E-BRANCH",
    "DUGBE, IBADAN",
    "DUTSE",
    "E BRANCH - ABULE EGBA",
    "EAGLE SQUARE ABUJA",
    "EAST WEST ROAD, PH 5",
    "E-BRANCH - DELSU",
    "E-BRANCH - LASPOTECH",
    "E-BRANCH - NAU",
    "E-BRANCH ABA ROAD",
    "EGBE BRANCH",
    "EKSU E-BRANCH",
    "ENUGU I - OGUI ROAD",
    "ENUGU II-RANGERS AVENUE",
    "EPE BRANCH",
    "EWEKORO",
    "FESTAC",
    "FESTAC 2",
    "FRANCE ROAD, KANO",
    "FUTA",
    "GARKI, AREA 3 - ABUJA",
    "GBAGADA E-BRANCH",
    "GOMBE",
    "GUSAU",
    "GWAGWALADA - ABUJA",
    "GWARIMPA",
    "IBAFO",
    "IDI - ORO",
    "IDIMU ROAD,EGBEDA",
    "IDIROKO",
    "IDUMOTA",
    "IJEBU - ODE",
    "IJU BRANCH",
    "IKEJA CANTONMENT ",
    "IKOM BRANCH",
    "IKORODU",
    "IKORODU 2",
    "IKORODU 3, AGRIC",
    "IKOSI",
    "IKOTA",
    "IKOTA E-BRANCH",
    "IKOTUN",
    "IKOTUN 2",
    "IKOYI- AWOLOWO ROAD",
    "IKWERRE ROAD, PH6",
    "ILE-IFE",
    "ILESA",
    "ILORIN",
    "ILORIN GRA",
    "ILORIN TAIWO RD",
    "ILUPEJU",
    "INDUSTRIAL LAYOUT PH7",
    "INTL AIRPORT RD ISOLO",
    "IPAJA",
    "ISOLO",
    "JABI BRANCH",
    "JABU",
    "JALINGO",
    "JOS I - JENGRE ROAD",
    "JOS II-AMHADU BELLO WAY",
    "KADUNA I- MM SQUARE",
    "KADUNA II- NNAMDI AZIKWE",
    "KADUNA III- KANO ROAD",
    "KADUNA IV- BARNAWA",
    "KANO BRANCH",
    "KANO III-BELLO ROAD",
    "KANO II-ZARIA ROAD",
    "KANO IV-BACHIRAWA ROAD",
    "KANO V-WAPA BRANCH",
    "KARU",
    "KARU 2",
    "KATSINA",
    "KETU",
    "KONTAGORA",
    "KRPC, KADUNA",
    "KUBWA - ABUJA",
    "KWARAPOLY",
    "LAFIA",
    "LAGOS ROAD BRANCH",
    "LASU",
    "LAUTECH E-BRANCH",
    "LAWANSON",
    "LEKKI",
    "LOKOJA",
    "LUTH",
    "MAGODO",
    "MAIDUGURI",
    "MAIDUGURI II",
    "MAKURDI",
    "MARINA",
    "MASHA",
    "MATORI",
    "MINNA",
    "MM WAY YABA",
    "MOBOLAJI BANK ANTHONY WAY",
    "MOKOLA BRANCH",
    "MOLONEY",
    "MUBI",
    "MUSHIN",
    "NAF BASE MAKURDI",
    "NDA BRANCH,KADUNA",
    "NIS-ABUJA",
    "NNAMDI AZIKWE ROAD PH 4",
    "NNEWI",
    "NSUKKA",
    "NTA RD,MGBUOBA-PHC 8",
    "OAU, ILE-IFE",
    "OBA AKRAN",
    "OBAJANA",
    "OFFA",
    "OGBA",
    "OGBA 2",
    "OGBOMOSO",
    "OGUDU E-BRANCH",
    "OJODU",
    "OJUELEGBA",
    "OKE-ARIN",
    "OKENE",
    "OKOTA",
    "OMOLE PHASE 2",
    "ONDO TOWN",
    "ONIPANU",
    "ONITSHA II - NEW MARKET",
    "ONITSHA III - BRIDGE HEAD",
    "OOU, AGO-IWOYE",
    "OPEBI",
    "OREGUN",
    "ORILE COKER",
    "OSHOGBO",
    "OSOGBO 2",
    "OWERRI",
    "OWERRI II",
    "OYO",
    "PLT 527, AMINU KANO CRES WUSE 2",
    "PLURAL HOUSE",
    "PROCESSING CENTER",
    "RCCG BRANCH",
    "RING ROAD - IBADAN",
    "RINGROAD E-BRANCH",
    "RVSG SECRETARIAT",
    "SAGAMU",
    "SANGO OTA 2",
    "SANGO OTTA",
    "SAPELE",
    "SHELL RA ANNEX",
    "SHELL RA OPERATIONS",
    "SHOGUNLE E-BRANCH",
    "SOBO AROBIODU IKEJA GRA",
    "SOKOTO",
    "SOKOTO 2",
    "ST. GREGORY DATA CENTRE",
    "SURULERE- BODE THOMAS",
    "TIAMIYU SAVAGE",
    "TRANS AMADI, PORT HARCOURT",
    "UMUAHIA",
    "UNAAB BRANCH",
    "UNIBEN E-BRANCH",
    "UNILAG",
    "UNILORIN BRANCH",
    "USMAN DAN FODIO UNI. SOKOTO III",
    "UYO",
    "UYO 2",
    "WARRI",
    "WESTERN AVENUE",
    "WOJI BRANCH",
    "WUSE 2 - ABUJA",
    "WUSE MARKET BRANCH",
    "YABA",
    "YABA LIBRARY",
    "YENAGOA",
    "YOLA",
    "ZARIA"
  ];

// Tyre Sizes (to be populated from Excel)
  List<String> tyreSizes = [
    "195/65/R15",
    "195/65/14",
    "185/70 R14",
    "215/70 R15",
    "195R15C",
    "195 R15",
    "185/65 R15",
    "225/70/R15",
    "205R16C",
    "205/70R15",
    "205/55R16",
    "215R16C",
    "185/60R15",
    "205R15C",
    "265/70/R16",
    "7.50 R16",
    "195/65/15R",
    "185/65/R15",
    "195R15C",
    "195/R15C",
    "185/70/R14",
    "195/65/R15",
    "195/65/ R15",
    "215/70R16",
    "265/60R18",
    "225/70R17C",
    "205/70R15C",
    "185/65R14",
    "285/60R18",
    "235/45 R18",
    "285/60R18",
  ];

  // Controllers for text fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController otherNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateEmployedController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

// Selected values for dropdowns
  String? selectedLevel;
  String? selectedProvider;

// List of dropdown options
  List<String> levelList = ["Relief", "Pilot 1", "Pilot 2", "Pilot 3", "Spy"];
  List<String> serviceProviderList = [
    "Ademakinwa Ademiluyi & Co",
    "Deeree Services Limited",
    "Fosad Consulting Limited",
    "Stresert Services Limited"
  ];

// Salary mapping based on level selection
  Map<String, String> salaryMap = {
    "Relief": "138,724.02",
    "Pilot 1": "200,000.00",
    "Pilot 2": "214,058.99",
    "Pilot 3": "232,622.83",
    "Spy": "243,670.39"
  };

  void loadFromExcel(
      List<String> branches, List<String> garages, List<String> sizes) {
    parkingBranches = branches;
    // maintenanceGarages = garages;
    tyreSizes = sizes;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Record',
                      style: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    S.h(4),
                    TextView(
                      text: 'Fill the information below to add a new record',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6E7C87),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.4, color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Information',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          S.h(8.h),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < 4; i++)
                                GestureDetector(
                                  onTap: () {
                                    pickImageFor(i);
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1.2,
                                          ),
                                        ),
                                        child: _pickedImages[i] == null
                                            ? Center(
                                                child: Icon(Icons.add,
                                                    color: Colors.grey,
                                                    size: 30),
                                              )
                                            : Stack(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child:
                                                          // image is Uint8List
                                                          //     ?
                                                          Image.memory(
                                                        _pickedImages[i],
                                                        width: 150,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                      )
                                                      // : Image.file(
                                                      //     _pickedImages[i],
                                                      //     width: 150,
                                                      //     height: 150,
                                                      //     fit: BoxFit.cover,
                                                      //   ),
                                                      ),
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          removeImageIndex(i),
                                                      child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            Colors.black54,
                                                        child: Icon(Icons.close,
                                                            size: 16,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        [
                                          "Front View",
                                          "Back View",
                                          "Side View",
                                          "Interior View"
                                        ][i],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          S.h(20.h),

                          // Row(
                          //   children: [
                          //     TextView(
                          //       text: "Upload Car Images",
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //     S.w(6.w),
                          //     InkResponse(
                          //       onTap: () => pickImages(),
                          //       child: Container(
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 20, vertical: 5),
                          //         decoration: BoxDecoration(
                          //             color: Colors.grey.withOpacity(0.02),
                          //             borderRadius: BorderRadius.circular(30),
                          //             border: Border.all(
                          //                 color: Color(0xffDDE2E4),
                          //                 width: 0.8)),
                          //         child: Row(
                          //           children: [
                          //             TextView(
                          //               text: 'Pick Images',
                          //               color: Color(0xff9AA6AC),
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.w600,
                          //             ),
                          //             S.w(4.w),
                          //             SvgPicture.asset(SvgAssets.edit,
                          //                 height: 14),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 12),
                          // _pickedImages.isNotEmpty
                          //     ? SizedBox(
                          //         height: 150,
                          //         child: ListView.builder(
                          //           scrollDirection: Axis.horizontal,
                          //           itemCount: _pickedImages.length,
                          //           itemBuilder: (context, index) {
                          //             final image = _pickedImages[index];

                          //             return Padding(
                          //               padding: const EdgeInsets.all(4.0),
                          //               child: ClipRRect(
                          //                 borderRadius:
                          //                     BorderRadius.circular(13),
                          //                 child: image is Uint8List
                          //                     ? Image.memory(
                          //                         image,
                          //                         width: 150,
                          //                         height: 150,
                          //                         fit: BoxFit.cover,
                          //                       )
                          //                     : Image.file(
                          //                         image,
                          //                         width: 150,
                          //                         height: 150,
                          //                         fit: BoxFit.cover,
                          //                       ),
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       )
                          //     : SizedBox.shrink(),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextField(
                                  label: "Asset Code",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Asset code is required';
                                    } else if (!RegExp(r'^[a-zA-Z0-9]{1,9}$')
                                        .hasMatch(value)) {
                                      return 'Max 9 alphanumeric characters (e.g. MVE113297)';
                                    }
                                    return null;
                                  },
                                  controller: assetCodeController,
                                  maxLength: 9,
                                ),
                              ),
                              S.w(10.w),
                              Flexible(
                                child: CustomTextField(
                                    label: "Reg Number",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Reg number is required';
                                      }
                                      // else if (!RegExp(
                                      //         r'^[A-Z]{2,3} \d{3} [A-Z]{1,2}$')
                                      //     .hasMatch(value)) {
                                      //   return 'Format: ABC 123 XY (max 8 alphanumeric characters)';
                                      // }
                                      return null;
                                    },
                                    controller: regNumberController,
                                    maxLength: 10,
                                    onChanged: (value) {
                                      String rawValue = value
                                          .toUpperCase()
                                          .replaceAll(RegExp(r'[^A-Z0-9]'), '');
                                      String formatted = '';

                                      if (rawValue.length > 3) {
                                        formatted +=
                                            rawValue.substring(0, 3) + ' ';
                                      } else {
                                        formatted += rawValue;
                                      }

                                      if (rawValue.length > 6) {
                                        formatted +=
                                            rawValue.substring(3, 6) + ' ';
                                      } else if (rawValue.length > 3) {
                                        formatted += rawValue.substring(3);
                                      }

                                      if (rawValue.length > 8) {
                                        formatted += rawValue.substring(6, 8);
                                      } else if (rawValue.length > 6) {
                                        formatted += rawValue.substring(6);
                                      }

                                      regNumberController.value =
                                          TextEditingValue(
                                        text: formatted,
                                        selection: TextSelection.collapsed(
                                            offset: formatted.length),
                                      );
                                    }),
                              ),
                              S.w(10.w),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: CustomDropdown(
                                    label: "Vehicle Category",
                                    value: vehicleCategory,
                                    items: vehicleCategories,
                                    onChanged: (val) =>
                                        setState(() => vehicleCategory = val),
                                    validator: (value) => value == null
                                        ? 'Select a vehicle category'
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextField(
                                  label: "Date Of Purchase",
                                  controller: dateOfPurchaseController,
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      dateOfPurchaseController.text =
                                          formattedDate;
                                      calculateNetBookValue();
                                    }
                                  },
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Date of purchase is required'
                                          : null,
                                ),
                              ),
                              S.w(10.w),
                              Flexible(
                                child: CustomTextField(
                                  label: "COST OF PURCHASE",
                                  controller: costOfPurchaseController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Cost of purchase is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => calculateNetBookValue(),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text(
                                      '₦',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              S.w(10.w),
                              Flexible(
                                child: CustomTextField(
                                  label: "NET BOOK VALUE",
                                  controller: netBookValueController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Net Book Value cannot be empty';
                                    } else if (double.tryParse(value) == null ||
                                        double.parse(value) < 0) {
                                      return 'Invalid value';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  label: "Vehicle Brand",
                                  value: vehicleBrand,
                                  items: vehicleBrands,
                                  onChanged: (val) {
                                    setState(() {
                                      vehicleBrand = val;
                                      vehicleModel = null;
                                      updateTankCapacity();
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? 'Select a vehicle brand'
                                      : null,
                                ),
                              ),
                              S.w(10.w),
                              Expanded(
                                child: CustomDropdown(
                                  label: "Vehicle Model",
                                  value: vehicleModel,
                                  items: vehicleModels,
                                  onChanged: (val) {
                                    setState(() {
                                      vehicleModel = val;
                                      updateTankCapacity();
                                    });
                                  },
                                  validator: (value) => value == null
                                      ? 'Select a vehicle model'
                                      : null,
                                ),
                              ),
                              S.w(10.w),
                              Expanded(
                                child: CustomDropdown(
                                  label: "Parking Branch",
                                  value: parkingBranch,
                                  items: teamBranchList,
                                  onChanged: (val) =>
                                      setState(() => parkingBranch = val),
                                  validator: (value) => value == null
                                      ? 'Select a parking branch'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              // VEHICLE TYPE
                              Expanded(
                                child: CustomDropdown(
                                  label: "Vehicle Type",
                                  value: vehicleType,
                                  items: vehicleTypes,
                                  onChanged: (val) =>
                                      setState(() => vehicleType = val),
                                  validator: (value) => value == null
                                      ? 'Select a vehicle type'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),

                              // TYRE TYPE
                              Expanded(
                                child: CustomDropdown(
                                  label: "Tyre Type",
                                  value: tyreType,
                                  items: tyreTypes,
                                  onChanged: (val) =>
                                      setState(() => tyreType = val),
                                  validator: (value) => value == null
                                      ? 'Select a tyre type'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),

                              // TYRE SIZE
                              Expanded(
                                child: CustomDropdown(
                                  label: "Tyre Size",
                                  value: tyreSize,
                                  items: tyreSizes,
                                  onChanged: (val) =>
                                      setState(() => tyreSize = val),
                                  validator: (value) => value == null
                                      ? 'Select a tyre size'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            children: [
                              // BATTERY TYPE
                              Expanded(
                                child: CustomDropdown(
                                  label: "Battery Type",
                                  value: batteryType,
                                  items: batteryTypes,
                                  onChanged: (val) =>
                                      setState(() => batteryType = val),
                                  validator: (value) => value == null
                                      ? 'Select a battery type'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),

                              // BATTERY SIZE
                              Expanded(
                                child: CustomDropdown(
                                  label: "Battery Size",
                                  value: batterySize,
                                  items: batterySizes,
                                  onChanged: (val) =>
                                      setState(() => batterySize = val),
                                  validator: (value) => value == null
                                      ? 'Select a battery size'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),

                              // TANK CAPACITY (Auto-filled based on brand and model)
                              Expanded(
                                child: CustomTextField(
                                  label: "Tank Capacity",
                                  controller: tankCapacityController,
                                  validator:
                                      MyFormValidator.contentValidator.call,
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18),
                          Row(
                            children: [
                              // VEHICLE STATUS
                              Expanded(
                                child: CustomDropdown(
                                  label: "Vehicle Status",
                                  value: vehicleStatus,
                                  items: [
                                    "Active",
                                    "Inactive",
                                    "Grounded",
                                    "Disposed"
                                  ],
                                  onChanged: (val) =>
                                      setState(() => vehicleStatus = val),
                                  validator: (value) => value == null
                                      ? 'Select vehicle status'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),

                              // MAINTENANCE GARAGE
                              Expanded(
                                child: CustomDropdown(
                                  label: "Maintenance Garage",
                                  value: maintenanceGarage,
                                  items: parkingBranches,
                                  onChanged: (val) =>
                                      setState(() => maintenanceGarage = val),
                                  validator: (value) => value == null
                                      ? 'Select a maintenance garage'
                                      : null,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18),
                          Text(
                            'Team Information',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          S.h(8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  label: "Class",
                                  value: selectedClass,
                                  items: classList, // From Excel
                                  onChanged: (val) =>
                                      setState(() => selectedClass = val),
                                  validator: (value) =>
                                      value == null ? 'Select a class' : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomDropdown(
                                  label: "Division",
                                  value: selectedDivision,
                                  items: divisionList, // From Excel
                                  onChanged: (val) =>
                                      setState(() => selectedDivision = val),
                                  validator: (value) => value == null
                                      ? 'Select a division'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomDropdown(
                                  label: "Group",
                                  value: selectedGroup,
                                  items: groupList, // From Excel
                                  onChanged: (val) =>
                                      setState(() => selectedGroup = val),
                                  validator: (value) =>
                                      value == null ? 'Select a group' : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Second Row: UNIT, TEAM BRANCH, PC CODE
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  label: "Unit",
                                  value: selectedUnit,
                                  items: unitList, // From Excel
                                  onChanged: (val) =>
                                      setState(() => selectedUnit = val),
                                  validator: (value) =>
                                      value == null ? 'Select a unit' : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomDropdown(
                                  label: "Team Branch",
                                  value: selectedTeamBranch,
                                  items: teamBranchList, // From Excel
                                  onChanged: (val) =>
                                      setState(() => selectedTeamBranch = val),
                                  validator: (value) => value == null
                                      ? 'Select a team branch'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "PC Code",
                                  controller: pcCodeController,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'PC Code is required'
                                          : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          // Third Row: REGION, TEAM EMAIL
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  label: "Region",
                                  value: selectedRegion,
                                  items: regionList, // From Excel
                                  onChanged: (val) =>
                                      setState(() => selectedRegion = val),
                                  validator: (value) =>
                                      value == null ? 'Select a region' : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Team Email",
                                  controller: teamEmailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Team Email is required';
                                    } else if (!RegExp(
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                        .hasMatch(value)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Text(
                            'Driver Information',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          S.h(8.h),
                          GestureDetector(
                            onTap: pickImage,
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: _pickedImage == null
                                      ? Center(
                                          child: Icon(Icons.add_a_photo,
                                              color: Colors.grey, size: 40),
                                        )
                                      : Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.memory(
                                                _pickedImage!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: removeImage,
                                                child: CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:
                                                      Colors.black54,
                                                  child: Icon(Icons.close,
                                                      size: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Upload Image",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),

                          S.h(8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: "Firstname",
                                  controller: firstNameController,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Firstname is required'
                                          : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Lastname",
                                  controller: lastNameController,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Lastname is required'
                                          : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                    label: "Othername",
                                    controller: otherNameController,
                                    validator: null),
                              ),
                            ],
                          ),
                          S.h(10.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: "ID",
                                  controller: idController,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(
                                  //       RegExp("[A-Z0-9]"))
                                  // ],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'ID is required'
                                          : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Phone Number",
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 11,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Phone Number is required';
                                    } else if (value.length != 11) {
                                      return 'Enter a valid 11-digit number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Date Employed",
                                  controller: dateEmployedController,
                                  readOnly: true,
                                  validator:
                                      MyFormValidator.contentValidator.call,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        dateEmployedController.text =
                                            formattedDate;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          S.h(10.h),

                          // Third row - Level, Service Provider, Salary
                          Row(
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  label: "Level",
                                  value: selectedLevel,
                                  items: [
                                    "Relief",
                                    "Pilot 1",
                                    "Pilot 2",
                                    "Pilot 3",
                                    "Spy"
                                  ],
                                  onChanged: (val) {
                                    setState(() {
                                      selectedLevel = val;
                                      salaryController.text =
                                          salaryMap[val] ?? "";
                                    });
                                  },
                                  validator: (value) =>
                                      value == null ? 'Select a level' : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomDropdown(
                                  label: "Service Provider",
                                  value: selectedProvider,
                                  items: [
                                    "Ademakinwa Ademiluyi & Co",
                                    "Deeree Services Limited",
                                    "Fosad Consulting Limited",
                                    "Stresert Services Limited"
                                  ],
                                  onChanged: (val) =>
                                      setState(() => selectedProvider = val),
                                  validator: (value) => value == null
                                      ? 'Select a provider'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Salary",
                                  controller: salaryController,
                                  readOnly: true,
                                  validator:
                                      MyFormValidator.contentValidator.call,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _dialogButton(
                                text: "Cancel",
                                color: Colors.grey[100]!,
                                textColor: Colors.grey,
                                onPressed: () => Navigator.pop(context),
                              ),
                              S.w(10.w),
                              GetBuilder<CarPortalController>(
                                  init: CarPortalController(),
                                  builder: (controller) {
                                    return controller.isBusy.value
                                        ? CupertinoActivityIndicator(
                                            radius: 10,
                                          )
                                        : _dialogButton(
                                            text: "Save Details",
                                            color: Colors.orange,
                                            textColor: Colors.white,
                                            onPressed: () async {
                                              setState(() {});
                                              // final processedImages = controller
                                              //     .processPickedImages(
                                              //         _pickedImages);
                                              // debugPrint(
                                              //     'Processed images: $processedImages');

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (_pickedImages.isEmpty) {
                                                  AppUtil.showSnackBar(
                                                      text:
                                                          "Please select at least one image.",
                                                      error: true);
                                                  return;
                                                }
                                                // debugPrint('these are images: $_pickedImages');
                                                // debugPrint('this is driver image: $_pickedImage');
                                                int salary = double.tryParse(
                                                            salaryController
                                                                .text
                                                                .replaceAll(
                                                                    ',', ''))
                                                        ?.round() ??
                                                    0;

                                                await carController
                                                    .startCreationProcess(
                                                        name: "${firstNameController.text.trim()} ${lastNameController.text.trim()} ${otherNameController.text.trim()}"
                                                            .trim(),
                                                        parseddriverId:
                                                            idController.text
                                                                .trim(),
                                                        phoneNumber:
                                                            phoneController.text
                                                                .trim(),
                                                        dateEmployed:
                                                            dateEmployedController
                                                                .text
                                                                .trim(),
                                                        level: int.tryParse(selectedLevel ?? "0") ??
                                                            0,
                                                        serviceProvider:
                                                            selectedProvider ??
                                                                "",
                                                        className:
                                                            selectedClass ?? "",
                                                        division:
                                                            selectedDivision ??
                                                                "",
                                                        group:
                                                            selectedGroup ?? "",
                                                        unit:
                                                            selectedUnit ?? "",
                                                        teamBranch:
                                                            selectedTeamBranch ??
                                                                "",
                                                        pcCode: pcCodeController
                                                            .text
                                                            .trim(),
                                                        region: selectedRegion ??
                                                            "",
                                                        vehicleBrandId:
                                                            vehicleBrand ?? "",
                                                        assetCode:
                                                            assetCodeController.text
                                                                .trim(),
                                                        regNumber:
                                                            regNumberController.text
                                                                .trim(),
                                                        vehicleCategory: vehicleCategory ?? "",
                                                        dateOfPurchase: dateOfPurchaseController.text.trim(),
                                                        costOfPurchase: int.tryParse(costOfPurchaseController.text) ?? 0,
                                                        netBookValue: int.tryParse(netBookValueController.text) ?? 0,
                                                        parkingBranch: parkingBranch ?? "",
                                                        vehicleType: vehicleType ?? "",
                                                        tyreType: tyreType ?? "",
                                                        batteryType: batteryType ?? "",
                                                        tankCapacity: int.tryParse(tankCapacityController.text.replaceAll('L', '')) ?? 0,
                                                        vehicleStatus: vehicleStatus ?? "",
                                                        maintenanceGarage: maintenanceGarage ?? "",
                                                        // fuelType: "", // Set this if needed
                                                        // available: true, // Modify if needed
                                                        vehicleModel: vehicleModel ?? "",
                                                        images: _pickedImages,
                                                        salary: salary,
                                                        email: teamEmailController.text);
                                              }
                                            },
                                          );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Reusable Dialog Button**
  Widget _dialogButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: onPressed,
      child: TextView(
        text: text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}

/// **Reusable TextField Widget**
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? onChanged;
  final bool readOnly;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;

  const CustomTextField(
      {required this.label,
      required this.controller,
      required this.validator,
      this.maxLength,
      this.readOnly = false,
      this.onChanged,
      this.onTap,
      this.keyboardType,
      this.inputFormatters,
      this.textCapitalization,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: label,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          style: TextStyle(fontSize: 12),
          maxLength: maxLength,
          readOnly: readOnly,
          onChanged: onChanged,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onTap: onTap,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffDDE2E4), width: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.02),
          ),
        ),
      ],
    );
  }
}

/// **Reusable Dropdown Widget**

// class CustomDropdown extends StatelessWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final Function(String?) onChanged;
//   final String? Function(String?)? validator;

//   const CustomDropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     required this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextView(
//           text: label,
//           color: Colors.black,
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//         ),
//         SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: value,
//           isExpanded: true,
//           validator: validator,
//           style: TextStyle(fontSize: 12),
//           isDense: true,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.red.withOpacity(0.6), width: 1.5),
//             ),
//             isDense: true,
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
//           ),
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black38),
//           items: items
//               .map((e) => DropdownMenuItem(
//                   value: e, child: TextView(text: e, fontSize: 12)))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }
