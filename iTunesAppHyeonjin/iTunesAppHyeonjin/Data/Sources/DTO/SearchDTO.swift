//
//  SearchDTO.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation

struct SearchDTO: Decodable {
    let results: [SearchResultDTO]
}

struct SearchResultDTO: Decodable {
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistId: Int?
    let collectionArtistName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    
    func toEntity() -> Track {
        Track(
            id: trackId,
            thunmbnailURL100: artworkUrl100 ?? "",
            title: trackName ?? "",
            artist: artistName ?? "",
            albumName: collectionName ?? ""
        )
    }
}
//"wrapperType": "track",
// "kind": "song",
// "artistId": 1696892396,
// "collectionId": 1701401671,
// "trackId": 1701401682,
// "artistName": "도화, 엘리, 여름, 예은, 유키, Fyeqoodgurl & 휘서",
// "collectionName": "퀸덤퍼즐 SEMI FINAL - Single",
// "trackName": "i DGA (i DONT GIVE A)",
// "collectionCensoredName": "퀸덤퍼즐 SEMI FINAL - Single",
// "trackCensoredName": "i DGA (i DONT GIVE A)",
// "collectionArtistId": 4035426,
// "collectionArtistName": "Various Artists",
// "artistViewUrl": "https://music.apple.com/kr/artist/%EB%8F%84%ED%99%94/1696892396?uo=4",
// "collectionViewUrl": "https://music.apple.com/kr/album/i-dga-i-dont-give-a/1701401671?i=1701401682&uo=4",
// "trackViewUrl": "https://music.apple.com/kr/album/i-dga-i-dont-give-a/1701401671?i=1701401682&uo=4",
// "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/12/cd/8a/12cd8a13-94b5-a8e3-ca8a-b754eec43504/mzaf_6780136262035397146.plus.aac.p.m4a",
// "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/31/89/d8/3189d8f4-942d-aa01-0c64-0fd481ae403c/888272121247_Cover.jpg/30x30bb.jpg",
// "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/31/89/d8/3189d8f4-942d-aa01-0c64-0fd481ae403c/888272121247_Cover.jpg/60x60bb.jpg",
// "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/31/89/d8/3189d8f4-942d-aa01-0c64-0fd481ae403c/888272121247_Cover.jpg/100x100bb.jpg",
// "releaseDate": "2023-08-09T12:00:00Z",
// "collectionExplicitness": "notExplicit",
// "trackExplicitness": "notExplicit",
// "discCount": 1,
// "discNumber": 1,
// "trackCount": 3,
// "trackNumber": 2,
// "trackTimeMillis": 199373,
// "country": "KOR",
// "currency": "KRW",
// "primaryGenreName": "K-Pop",
// "isStreamable": true
