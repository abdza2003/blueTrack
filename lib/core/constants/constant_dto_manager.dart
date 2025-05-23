// import 'package:hypermart/services/dto/constant_dto.dart';

// class ConstantDtoManager {
//   static final ConstantDtoManager instance = ConstantDtoManager._internal();
//   ConstantDtoManager._internal();

//   final List<ConstantDTO> canBulanSevkYeriList = [
//     ConstantDTO(text: 'Bakım Evi', value: '1'),
//     ConstantDTO(text: "Veterinerlik Fakültesi", value: '2'),
//     ConstantDTO(text: 'Ölüm', value: '3'),
//     ConstantDTO(text: 'Kaçtı', value: '4'),
//   ];
//   final List<ConstantDTO> canBulanOnaylamaDurumlarList = [
//     ConstantDTO(text: 'Onay Bekliyor', value: '1'),
//     ConstantDTO(text: "Onaylandı", value: '2'),
//     ConstantDTO(text: 'Reddedildi', value: '3'),
//   ];

//   final List<ConstantDTO> canBulanHayvanCinsiyet = [
//     ConstantDTO(text: 'Erkek', value: '1'),
//     ConstantDTO(text: "Dişi", value: '2'),
//   ];
//   final List<ConstantDTO> onaylamaDurumlarList = [
//     ConstantDTO(text: 'Onay Bekliyor', value: '1'),
//     ConstantDTO(text: "Onaylandı", value: '2'),
//     ConstantDTO(text: 'Reddedildi', value: '3'),
//   ];

//   final List<ConstantDTO> canBulanSevkUcertDurumlari = [
//     ConstantDTO(text: 'Tümü', value: '0'),
//     ConstantDTO(text: 'Ücreti Girilmiş', value: '1'),
//     ConstantDTO(text: 'Ücreti Girilmemiş', value: '3'),
//   ];
//   final List<ConstantDTO> canBulanSevkEden = [
//     ConstantDTO(text: 'CANBULAN', value: '1'),
//     ConstantDTO(text: "Vatandaş", value: '2'),
//     ConstantDTO(text: 'İlçe Belediyeleri', value: '3'),
//   ];
//   final List<ConstantDTO> canBulanIhbarBilgi = [
//     ConstantDTO(text: 'CANBULAN', value: '1'),
//     ConstantDTO(text: "Vatandaş", value: '2'),
//     ConstantDTO(text: 'İlçe Belediyeleri', value: '3'),
//     ConstantDTO(text: 'Hayvan Sever', value: '4'),
//   ];
//   final List<ConstantDTO> ihbarBirimiList = [
//     ConstantDTO(text: "Vatandaş", value: '1'),
//     ConstantDTO(text: "Büyükşehir", value: '2'),
//     ConstantDTO(text: 'İlçe Belediyeleri', value: '3'),
//     ConstantDTO(text: 'Hayvan Sever', value: '4'),
//   ];

//   final List<ConstantDTO> canBulanSevkCikisTuruList = [
//     ConstantDTO(text: 'Taburcu', value: '1'),
//     ConstantDTO(text: "Ölüm", value: '2'),
//     ConstantDTO(text: 'Bakım Evi Taburcu', value: '3'),
//   ];

//   final List<ConstantDTO> bRNK2HayvanCikisTipi = [
//     ConstantDTO(text: 'Sahiplendirilme', value: '2'),
//     ConstantDTO(text: "Gönüllü", value: '3'),
//     ConstantDTO(text: 'Kafesten Kaçma', value: '4'),
//     ConstantDTO(text: 'İlçeler Dağıtımı', value: '5'),
//     ConstantDTO(text: 'Ölüm', value: '6'),
//     ConstantDTO(text: 'Yavru Çıkışı', value: '7'),
//   ];
//   final List<ConstantDTO> canliDurumBilgisi = [
//     ConstantDTO(text: 'Barınakta', value: '1'),
//     ConstantDTO(text: 'Sahiplendirilme', value: '2'),
//     ConstantDTO(text: "Gönüllü", value: '3'),
//     ConstantDTO(text: 'Kafesten Kaçma', value: '4'),
//     ConstantDTO(text: 'İlçeler Dağıtımı', value: '5'),
//     ConstantDTO(text: 'Ölüm', value: '6'),
//   ];
//   final List<ConstantDTO> gonulluHayvanDurum = [
//     ConstantDTO(text: 'Barınakta', value: '1'),
//     ConstantDTO(text: 'Sahiplendirildi', value: '2'),
//     ConstantDTO(text: "Kaçtı", value: '3'),
//     ConstantDTO(text: 'Öldü', value: '4'),
//   ];
//   final List<ConstantDTO> gonulluSahiplendrimeDurum = [
//     ConstantDTO(text: 'Sahiplendirildi', value: '2'),
//     ConstantDTO(text: "Kaçtı", value: '3'),
//     ConstantDTO(text: 'Öldü', value: '4'),
//     ConstantDTO(text: 'Geri Alındı', value: '5'),
//   ];
//   final List<ConstantDTO> gidecegiYer = [
//     ConstantDTO(text: 'Barınak', value: '1'),
//     ConstantDTO(text: 'Hastane', value: '2'),
//   ];
//   final List<ConstantDTO> gonulluHayvanBolge = [
//     ConstantDTO(text: 'A Bölge', value: '1'),
//     ConstantDTO(text: 'B Bölge', value: '2'),
//     ConstantDTO(text: 'C Bölge', value: '3'),
//   ];

//   final List<ConstantDTO> months = [
//     ConstantDTO(text: 'Ocak', value: '1'),
//     ConstantDTO(text: 'Şubat', value: '2'),
//     ConstantDTO(text: 'Mart', value: '3'),
//     ConstantDTO(text: 'Nisan', value: '4'),
//     ConstantDTO(text: 'Mayıs', value: '5'),
//     ConstantDTO(text: 'Haziran', value: '6'),
//     ConstantDTO(text: 'Temmuz', value: '7'),
//     ConstantDTO(text: 'Ağustos', value: '8'),
//     ConstantDTO(text: 'Eylül', value: '9'),
//     ConstantDTO(text: 'Ekim', value: '10'),
//     ConstantDTO(text: 'Kasım', value: '11'),
//     ConstantDTO(text: 'Aralık', value: '12'),
//   ];

//   final List<ConstantDTO> years = [
//     ConstantDTO(text: '2020', value: '2020'),
//     ConstantDTO(text: '2021', value: '2021'),
//     ConstantDTO(text: '2022', value: '2022'),
//     ConstantDTO(text: '2023', value: '2023'),
//     ConstantDTO(text: '2024', value: '2024'),
//     ConstantDTO(text: '2025', value: '2025'),
//     ConstantDTO(text: '2026', value: '2026'),
//   ];

//   final List<ConstantDTO> gonulluDenetlemeDurum = [
//     ConstantDTO(text: 'Bekleyenler', value: '0'),
//     ConstantDTO(text: "Yerinde", value: '5'),
//     ConstantDTO(text: 'Öldü', value: '4'),
//     ConstantDTO(text: 'Kaçtı', value: '3'),
//     ConstantDTO(text: 'Geri Alındı', value: '7'),
//   ];

//   final List<ConstantDTO> gonulluDenetlemeDurumUpdate = [
//     ConstantDTO(text: "Yerinde", value: '5'),
//     ConstantDTO(text: 'Öldü', value: '4'),
//     ConstantDTO(text: 'Kaçtı', value: '3'),
//     ConstantDTO(text: 'Geri Alındı', value: '7'),
//   ];

//   final List<ConstantDTO> hayvanHareketTipleri = [
//     ConstantDTO(value: "1", text: 'Hayvan Giriş'),
//     ConstantDTO(value: "2", text: 'Toplu Kafes Değişimi'),
//     ConstantDTO(value: "3", text: 'Aşı'),
//     ConstantDTO(value: "4", text: 'Tedavi'),
//     ConstantDTO(value: "5", text: 'Özel Not'),
//     ConstantDTO(value: "6", text: 'Hayvan Çıkış'),
//     ConstantDTO(value: "7", text: 'Kafes Değişimi'),
//   ];

//   final List<ConstantDTO> hayvanIslemeleriGidecegiYer = [
//     ConstantDTO(value: "1", text: 'Barınak'),
//     ConstantDTO(value: "2", text: 'Hastane'),
//     ConstantDTO(value: "-1", text: 'Belirsiz'),
//   ];
// }
