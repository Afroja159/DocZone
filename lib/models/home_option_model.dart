class HomeOptionModel {
  String? image, title;

  HomeOptionModel({this.image, this.title});
}

List<HomeOptionModel> homeOptionList1 = [
  HomeOptionModel(
    image: 'assets/icons/bmi.svg',
    title: 'BMI Calculator',
  ),
  HomeOptionModel(
    image: 'assets/icons/healthTips.svg',
    title: 'Health Tips',
  ),
];

List<HomeOptionModel> homeOptionList2 = [
  HomeOptionModel(
    image: 'assets/icons/doctorsZone.svg',
    title: 'Doctors Zone',
  ),
  HomeOptionModel(
    image: 'assets/icons/mediTime.svg',
    title: 'Medi Time',
  ),
  HomeOptionModel(
    image: 'assets/icons/bloodCenter.svg',
    title: 'Blood Center',
  ),
  HomeOptionModel(
    image: 'assets/icons/covid19.svg',
    title: 'Covid-19',
  ),
  HomeOptionModel(
    image: 'assets/icons/999.svg',
    title: '999',
  ),
  HomeOptionModel(
    image: 'assets/icons/contactHospital.svg',
    title: 'Call Hospital',
  ),
];
