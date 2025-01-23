import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';

class FnbFaker {
  static FnbDetailModel getPlaceDetail() {
    return FnbDetailModel(
      addressComponents: [],
      formattedAddress:
          'Jl. Prof. DR. Soepomo No.55B, RT.13/RW.2, Tebet Bar., Kec. Tebet, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12810, Indonesia',
      formattedPhoneNumber: '',
      icon:
          'https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png',
      iconBackgroundColor: '#FF9E67',
      iconMaskBaseUri:
          'https://maps.gstatic.com/mapfiles/place_api/icons/v2/restaurant_pinlet',
      internationalPhoneNumber: '',
      name: 'Sambal Bakar Mang Asep',
      photos: [
        Photo(
          height: 200,
          htmlAttributions: [],
          photoReference: 'https://picsum.photos/id/56/200/200',
          width: 200,
        ),
        Photo(
          height: 200,
          htmlAttributions: [],
          photoReference: 'https://picsum.photos/id/57/200/200',
          width: 200,
        ),
        Photo(
          height: 200,
          htmlAttributions: [],
          photoReference: 'https://picsum.photos/id/58/200/200',
          width: 200,
        )
      ],
      placeId: 'ChIJhY1IdJTzaS4RCliiU3D4Z9I',
      priceLevel: 3,
      reference: 'ChIJhY1IdJTzaS4RCliiU3D4Z9I',
      businessStatus: true,
      openNow: true,
      delivery: true,
      dineIn: true,
      rating: 4.1,
      website: 'http://mcdonalds.co.id/',
      url: 'https://maps.google.com/?cid=15161359831889238026',
      reviews: [],
      types: ["restaurant", "food", "point_of_interest", "establishment"],
      geometry: Geometry(location: FnbDetailLocation(lat: 12.1, lng: 12.1)),
      currentOpeningHours: CurrentOpeningHours(
        openNow: false,
        weekdayText: [
          "Monday: Open 24 hours",
          "Tuesday: Open 24 hours",
          "Wednesday: Open 24 hours",
          "Thursday: Open 24 hours",
          "Friday: Open 24 hours",
          "Saturday: Open 24 hours",
          "Sunday: Open 24 hours"
        ],
      ),
    );
  }

  static List<FnbNearestModel> getPlacesNearest() {
    final List<FnbNearestModel> data = [];
    data.addAll([
      FnbNearestModel(
        id: '6791fbcb455d78afb119d7bf',
        location: FnbNearestLocation(
            type: 'Point', coordinates: [106.7811361, -6.3115532]),
        name: 'Seselera Lebak Bulus',
        fullAddress:
            'Jl. Karang Tengah Raya No.14, RT.2/RW.3, Lb. Bulus, Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12440',
        street: 'Jl. Karang Tengah Raya No.14',
        municipality: 'RT.2/RW.3, Lebak Bulus',
        categories: ['Restoran Asia, Restoran'],
        timezone: 'Asia/Jakarta',
        phone: '0882-9871-5567',
        phones: ['0882-9871-5567', '+62 882-9871-5567'],
        claimed: "YES",
        reviewCount: 17,
        averageRating: 4.6,
        reviewUrl:
            'https://search.google.com/local/reviews?placeid=ChIJd8CMFfXvaS4RDuAu5fTSUNw&q=Restoran&authuser=0&hl=in&gl=ID',
        googleMapsUrl: 'https://www.google.com/maps?cid=15875420635739906062',
        latitude: -6.3115532,
        longitude: 106.7811361,
        website: 'https://linktr.ee/Seselera',
        openingHours:
            'Senin: [10.00-21.00], Selasa: [10.00-21.00], Rabu: [10.00-21.00], Kamis: [10.00-21.00], Jumat: [10.00-21.00], Sabtu: [10.00-21.00], Minggu: [10.00-21.00]',
        featuredImage:
            'https://lh5.googleusercontent.com/p/AF1QipNKiR3NLWNGpz8Hn6Iip8ytvVPN0kCRKHtY4QYT=w163-h92-k-no',
        cid: '15875420635739900000',
        fid: '0x2e69eff5158cc077:0xdc50d2f4e52ee00e',
        placeId: 'ChIJd8CMFfXvaS4RDuAu5fTSUNw',
      ),
      FnbNearestModel(
        id: 'ChIJC6LZ7WvvaS4R4tkA_sGiqmk',
        location: FnbNearestLocation(
            type: 'Point', coordinates: [106.781349699999, -6.3109321]),
        name: 'Toodz House - Karang Tengah',
        fullAddress:
            'MQQJ+JGH, Jl. Karang Tengah Raya, RT.4/RW.3, Lb. Bulus, Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12440',
        street: 'MQQJ+JGH',
        municipality: 'Jl. Karang Tengah Raya',
        categories: ['Restoran'],
        timezone: 'Asia/Jakarta',
        phone: '(021) 22769647',
        phones: ['(021) 22769647'],
        claimed: "NO",
        reviewCount: 675,
        averageRating: 4.7,
        reviewUrl:
            'https://search.google.com/local/reviews?placeid=ChIJC6LZ7WvvaS4R4tkA_sGiqmk&q=Restoran&authuser=0&hl=in&gl=ID',
        googleMapsUrl: 'https://www.google.com/maps?cid=7614077074097101282',
        latitude: -6.3109321,
        longitude: 106.781349699999,
        website: '',
        openingHours:
            'Senin: [08.00-22.00], Selasa: [08.00-22.00], Rabu: [08.00-22.00], Kamis: [08.00-22.00], Jumat: [13.00-22.00], Sabtu: [08.00-22.00], Minggu: [08.00-22.00]',
        featuredImage:
            'https://lh5.googleusercontent.com/p/AF1QipOs-DHCuwxxat5dQ3dfgpdqeddVqSglNtAw0_hh=w80-h106-k-no',
        cid: '7614077074097098752',
        fid: '0x2e69ef6bedd9a20b:0x69aaa2c1fe00d9e2',
        placeId: 'ChIJC6LZ7WvvaS4R4tkA_sGiqmk',
      ),
      FnbNearestModel(
        id: 'ChIJsW2N3VDxaS4RKifOdjR0J5c',
        location: FnbNearestLocation(
            type: 'Point', coordinates: [106.7810944, -6.3114662]),
        name: 'DAPOER LAHPER',
        fullAddress:
            'Jl. Karang Tengah Raya No.16, Lb. Bulus, Kec. Cilandak, Jakarta, Daerah Khusus Ibukota Jakarta 12440',
        street: 'Jl. Karang Tengah Raya No.16',
        municipality: 'Lb. Bulus',
        categories: ['Restoran Mie', 'Restoran Masakan Ayam'],
        timezone: 'Asia/Jakarta',
        phone: '(021) 22769647',
        phones: ['(021) 22769647'],
        claimed: "NO",
        reviewCount: 101,
        averageRating: 4.7,
        reviewUrl:
            'https://search.google.com/local/reviews?placeid=ChIJsW2N3VDxaS4RKifOdjR0J5c&q=Restoran&authuser=0&hl=in&gl=ID',
        googleMapsUrl: 'https://www.google.com/maps?cid=10891801992499177258',
        latitude: -6.3114662,
        longitude: 106.7810944,
        website: '',
        openingHours:
            'Senin: [11.00-21.00], Selasa: [11.00-21.00], Rabu: [11.00-21.00], Kamis: [11.00-21.00], Jumat: [11.00-21.00], Sabtu: [11.00-21.00], Minggu: [11.00-21.00]',
        featuredImage:
            'https://lh5.googleusercontent.com/p/AF1QipOSmOkVzXbB-xFT4pshWb4zCx4hOqoN6ZLI0Vmo=w163-h92-k-no',
        cid: '10891801992499100000',
        fid: '0x2e69f150dd8d6db1:0x9727743476ce272a',
        placeId: 'ChIJsW2N3VDxaS4RKifOdjR0J5c',
      ),
    ]);

    return data;
  }
}
