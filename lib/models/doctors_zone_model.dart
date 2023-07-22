class DoctorsZoneModel {
  String? docName, education, specialist, timeA, timeB, timeC;
  DoctorsZoneModel(
      {this.docName,
      this.education,
      this.specialist,
      this.timeA,
      this.timeB,
      this.timeC});
}

List<DoctorsZoneModel> doctorsList = [
  DoctorsZoneModel(
    docName: "Dr.Bibekananda Biswas",
    education: "M.B.B.S, F.C.P.S",
    specialist: "Eye",
    timeA: "Sat - 6pm to 9pm",
    timeB: "Mon - 6pm to 9pm",
    timeC: "Wed - 6pm to 9pm",
  ),
  DoctorsZoneModel(
    docName: "Dr.Brig.Gen.(Rtd.)A.B.M Syeed Hosain",
    education: "M.B.B.S, DCN(London)",
    specialist: "Medicine & Neuromedicine",
    timeA: "Sat - 4pm to 7pm",
    timeB: "Tue - 4pm to 7pm",
    timeC: "Thu - 4pm to 7pm",
  ),
  DoctorsZoneModel(
    docName: "Dr.Parul Akhtar",
    education: "M.B.B.S, F.C.P.S",
    specialist: "Gynecologist",
    timeA: "Sat - 3pm to 7pm",
    timeB: "Mon - 3pm to 7pm",
  ),
  DoctorsZoneModel(
    docName: "Dr.Ranjit Kumar Banik",
    education: "M.B.B.S, F.C.P.S",
    specialist: "Liver & Medicine",
    timeA: "Sat - 6pm to 9pm",
    timeB: "Mon - 6pm to 9pm",
    timeC: "Wed - 6pm to 9pm",
  ),
  DoctorsZoneModel(
    docName: "Dr.A.H.M. Waliur Rahman Sumon",
    education: "F.C.P.S",
    specialist: "Medicine",
    timeA: "Sat - 4pm to 7pm",
    timeB: "Tue - 4pm to 7pm",
    timeC: "Thu - 4pm to 7pm",
  ),
  DoctorsZoneModel(
    docName: "Dr. MD. Mohabbat Ullah",
    education: "M.B.B.S, MS",
    specialist: "Orthopedic",
    timeA: "Sat - 3pm to 7pm",
    timeB: "Mon - 3pm to 7pm",
  ),
  DoctorsZoneModel(
    docName: "Dr. Benozir Haque Panna",
    education: "M.B.B.S, F.C.P.S",
    specialist: "Gynecologist",
    timeA: "Sat - 6pm to 9pm",
    timeB: "Mon - 6pm to 9pm",
    timeC: "Wed - 6pm to 9pm",
  ),
  DoctorsZoneModel(
    docName: "Dr. M.A. Malek Murad",
    education: "M.B.B.S, MS",
    specialist: "Orthopedic",
    timeA: "Sat - 4pm to 7pm",
    timeB: "Tue - 4pm to 7pm",
    timeC: "Thu - 4pm to 7pm",
  ),
  DoctorsZoneModel(
    docName: "Dr. MD. Abul Kalam Azad",
    education: "M.B.B.S, MD",
    specialist: "Skin",
    timeA: "Sat - 3pm to 7pm",
    timeB: "Mon - 3pm to 7pm",
  ),
  DoctorsZoneModel(
    docName: "Dr. Mst. Mira Parvin",
    education: "M.B.B.S, F.C.P.S",
    specialist: "Breast & Piles Surgeon",
    timeA: "Sat - 4pm to 7pm",
    timeB: "Tue - 4pm to 7pm",
    timeC: "Thu - 4pm to 7pm",
  ),
];
