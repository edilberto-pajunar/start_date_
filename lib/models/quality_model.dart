class Quality {
  final String relationship;
  final String dayAvail;
  final String timeAvail;
  final String birthday;
  final String gender;
  final String genderPref;
  final String height;
  final String heightPref;
  final String ethnicity;
  final String ethnicityPref;
  final String memberFraternity;
  final String memberFraternityPref;
  final String yearLevel;
  final String yearLevelPref;
  final String doDrink;
  final String doDrinkPref;
  final String doSmoke;
  final String doSmokePref;

  const Quality({
    required this.relationship,
    required this.dayAvail,
    required this.timeAvail,
    required this.birthday,
    required this.gender,
    required this.genderPref,
    required this.height,
    required this.heightPref,
    required this.ethnicity,
    required this.ethnicityPref,
    required this.memberFraternity,
    required this.memberFraternityPref,
    required this.yearLevel,
    required this.yearLevelPref,
    required this.doDrink,
    required this.doDrinkPref,
    required this.doSmoke,
    required this.doSmokePref,
  });

  Quality copyWith({
    String? relationship,
    String? dayAvail,
    String? timeAvail,
    String? birthday,
    String? gender,
    String? genderPref,
    String? height,
    String? heightPref,
    String? ethnicity,
    String? ethnicityPref,
    String? memberFraternity,
    String? memberFraternityPref,
    String? yearLevel,
    String? yearLevelPref,
    String? doDrink,
    String? doDrinkPref,
    String? doSmoke,
    String? doSmokePref,
  }) =>
      Quality(
        relationship: relationship ?? this.relationship,
        dayAvail: dayAvail ?? this.dayAvail,
        timeAvail: timeAvail ?? this.timeAvail,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        genderPref: genderPref ?? this.genderPref,
        height: height ?? this.height,
        heightPref: heightPref ?? this.heightPref,
        ethnicity: ethnicity ?? this.ethnicity,
        ethnicityPref: ethnicityPref ?? this.ethnicityPref,
        memberFraternity: memberFraternity ?? this.memberFraternity,
        memberFraternityPref: memberFraternityPref ?? this.memberFraternityPref,
        yearLevel: yearLevel ?? this.yearLevel,
        yearLevelPref: yearLevelPref ?? this.yearLevelPref,
        doDrink: doDrink ?? this.doDrink,
        doDrinkPref: doDrinkPref ?? this.doDrinkPref,
        doSmoke: doSmoke ?? this.doSmoke,
        doSmokePref: doSmokePref ?? this.doSmokePref,
      );

  factory Quality.fromJson(Map<String, dynamic> json) => Quality(
        relationship: json["relationship"],
        dayAvail: json["day_avail"],
        timeAvail: json["time_avail"],
        birthday: json["birthday"],
        gender: json["gender"],
        genderPref: json["gender_pref"],
        height: json["height"],
        heightPref: json["height_pref"],
        ethnicity: json["ethnicity"],
        ethnicityPref: json["ethnicity_pref"],
        memberFraternity: json["member_fraternity"],
        memberFraternityPref: json["member_fraternity_pref"],
        yearLevel: json["year_level"],
        yearLevelPref: json["year_level_pref"],
        doDrink: json["do_drink"],
        doDrinkPref: json["do_drink_pref"],
        doSmoke: json["do_smoke"],
        doSmokePref: json["do_smoke_pref"],
      );

  Map<String, dynamic> toJson() => {
        "relationship": relationship,
        "day_avail": dayAvail,
        "time_avail": timeAvail,
        "birthday": birthday,
        "gender": gender,
        "gender_pref": genderPref,
        "height": height,
        "height_pref": heightPref,
        "ethnicity": ethnicity,
        "ethnicity_pref": ethnicityPref,
        "member_fraternity": memberFraternity,
        "member_fraternity_pref": memberFraternityPref,
        "year_level": yearLevel,
        "year_level_pref": yearLevelPref,
        "do_drink": doDrink,
        "do_drink_pref": doDrinkPref,
        "do_smoke": doSmoke,
        "do_smoke_pref": doSmokePref,
      };

  static const Quality empty = Quality(
    relationship: "",
    dayAvail: "",
    timeAvail: "",
    birthday: "",
    gender: "",
    genderPref: "",
    height: "",
    heightPref: "",
    ethnicity: "",
    ethnicityPref: "",
    memberFraternity: "",
    memberFraternityPref: "",
    yearLevel: "",
    yearLevelPref: "",
    doDrink: "",
    doDrinkPref: "",
    doSmoke: "",
    doSmokePref: "",
  );
}
