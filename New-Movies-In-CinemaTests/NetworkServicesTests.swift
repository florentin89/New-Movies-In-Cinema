//
//  NetworkServicesTests.swift
//  New-Movies-In-CinemaTests
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import XCTest
@testable import movies_in_theaters_m_s

class NetworkServicesTests: XCTestCase {
    
    //    override func setUp() [
    //        super.setUp()
    //    ]
    //
    //    override func tearDown() [
    //        super.tearDown()
    //    ]
    
    func testURLComponents() {
        let string = NetworkServices.shared.createURLComponents(for: NetworkServices.Services.nowPlaying).url?.absoluteString
        XCTAssertEqual(string, "https://api.themoviedb.org/3/movie/now_playing?api_key=4f811f64687fc0038b16d5c4a8749c15")
        
        let string1 = NetworkServices.shared.createURLComponents(for: NetworkServices.Services.movieDetails).url?.absoluteString
        XCTAssertEqual(string1, "https://api.themoviedb.org/3/movie?api_key=4f811f64687fc0038b16d5c4a8749c15")
        
        let string2 = NetworkServices.shared.createURLComponents(for: NetworkServices.Services.collectionDetails).url?.absoluteString
        XCTAssertEqual(string2, "https://api.themoviedb.org/3/collection?api_key=4f811f64687fc0038b16d5c4a8749c15")
    }
    
    func testMovieObject() {
        let rawMovie: [String:Any] = ["adult":false,"backdrop_path":"/5qxePyMYDisLe8rJiBYX8HKEyv2.jpg","belongs_to_collection":["id":87359,"name":"Mission: Impossible Collection","poster_path":"/gwyJPIhCK4Xz2WogeBnhCSQfUek.jpg","backdrop_path":"/1kvKAHlSdFZTT9mhAXR54ggkxOU.jpg"],"budget":178000000,"genres":[["id":12,"name":"Adventure"],["id":28,"name":"Action"],["id":53,"name":"Thriller"]],"id":353081,"imdb_id":"tt4912910","original_language":"en","original_title":"Mission: Impossible - Fallout","overview":"When an IMF mission ends badly, the world is faced with dire consequences. As Ethan Hunt takes it upon himself to fulfil his original briefing, the CIA begin to question his loyalty and his motives. The IMF team find themselves in a race against time, hunted by assassins while trying to prevent a global catastrophe.","popularity":445.872,"poster_path":"/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg","production_companies":[["id":4,"logo_path":"/fycMZt242LVjagMByZOLUGbCvv3.png","name":"Paramount","origin_country":"US"],["id":11461,"logo_path":"/p9FoEt5shEKRWRKVIlvFaEmRnun.png","name":"Bad Robot","origin_country":"US"],["id":82819,"logo_path":"/5Z8WWr0Lf1tInVWwJsxPP0uMz9a.png","name":"Skydance Media","origin_country":"US"]],"production_countries":[["iso_3166_1":"US","name":"United States of America"]],"release_date":"2018-07-25","revenue":153500000,"runtime":147,"spoken_languages":[["iso_639_1":"en","name":"English"]],"status":"Released","tagline":"Some Missions Are Not A Choice","title":"Mission: Impossible - Fallout","video":false,"vote_average":7.6,"vote_count":214]
        let movie = NetworkServices.shared.movie(from: rawMovie)
        XCTAssertEqual(movie?.id, 353081)
        XCTAssertEqual(movie?.title, "Mission: Impossible - Fallout")
    }
    
    func testMovieCollectionObject() {
        let rawCollection: [String:Any] = ["id":87359,"name":"Mission: Impossible Collection","overview":"Mission: Impossible is a series of a secret agent thriller films based on the popular television series. They chronicle the missions of a team of secret government agents known as the Impossible Missions Force (IMF) under the leadership of Hunt.","poster_path":"/gwyJPIhCK4Xz2WogeBnhCSQfUek.jpg","backdrop_path":"/1kvKAHlSdFZTT9mhAXR54ggkxOU.jpg","parts":[["adult":false,"backdrop_path":"/tjQHn6xW5BiB1RJ3OZIPDzIOSkF.jpg","genre_ids":[28,12,53],"id":954,"original_language":"en","original_title":"Mission: Impossible","overview":"When Ethan Hunt, the leader of a crack espionage team whose perilous operation has gone awry with no explanation, discovers that a mole has penetrated the CIA, he's surprised to learn that he's the No. 1 suspect. To clear his name, Hunt now must ferret out the real double agent and, in the process, even the score.","poster_path":"/vmj2PzTLC6xJvshpq8SlaYE3gbd.jpg","release_date":"1996-05-22","title":"Mission: Impossible","video":false,"vote_average":6.8,"vote_count":3644,"popularity":205.919],["adult":false,"backdrop_path":"/bDdVZNvxb670EMlZqeIy6RdyJ4V.jpg","genre_ids":[28,12,53],"id":955,"original_language":"en","original_title":"Mission: Impossible II","overview":"With computer genius Luther Stickell at his side and a beautiful thief on his mind, agent Ethan Hunt races across Australia and Spain to stop a former IMF agent from unleashing a genetically engineered biological weapon called Chimera. This mission, should Hunt choose to accept it, plunges him into the center of an international crisis of terrifying magnitude.","poster_path":"/eRaEC0vf5q5TSvaoJPwGTt2wa9T.jpg","release_date":"2000-05-24","title":"Mission: Impossible II","video":false,"vote_average":6.0,"vote_count":2692,"popularity":112.442],["adult":false,"backdrop_path":"/kOELgNnVt6EGCjtDXx85YUw6p8X.jpg","genre_ids":[28,12,53],"id":956,"original_language":"en","original_title":"Mission: Impossible III","overview":"Retired from active duty to train new IMF agents, Ethan Hunt is called back into action to confront sadistic arms dealer, Owen Davian. Hunt must try to protect his girlfriend while working with his new team to complete the mission.","poster_path":"/qjy8ABAbWooV4jLG6UjzDHlv4RB.jpg","release_date":"2006-05-03","title":"Mission: Impossible III","video":false,"vote_average":6.5,"vote_count":2755,"popularity":113.444],["adult":false,"backdrop_path":"/pc7a2qrIkIxzqWGqcexd3mHzIxy.jpg","genre_ids":[28,12,53],"id":56292,"original_language":"en","original_title":"Mission: Impossible - Ghost Protocol","overview":"Ethan Hunt and his team are racing against time to track down a dangerous terrorist named Hendricks, who has gained access to Russian nuclear launch codes and is planning a strike on the United States. An attempt to stop him ends in an explosion causing severe destruction to the Kremlin and the IMF to be implicated in the bombing, forcing the President to disavow them. No longer being aided by the government, Ethan and his team chase Hendricks around the globe, although they might still be too late to stop a disaster.","poster_path":"/s58mMsgIVOFfoXPtwPWJ3hDYpXf.jpg","release_date":"2011-12-07","title":"Mission: Impossible - Ghost Protocol","video":false,"vote_average":6.9,"vote_count":4981,"popularity":156.471],["adult":false,"backdrop_path":"/8XeLfNQrDmFQmPTqxapfWUnKiLf.jpg","genre_ids":[28,12,53],"id":177677,"original_language":"en","original_title":"Mission: Impossible - Rogue Nation","overview":"Ethan and team take on their most impossible mission yet, eradicating the Syndicate - an International rogue organization as highly skilled as they are, committed to destroying the IMF.","poster_path":"/z2sJd1OvAGZLxgjBdSnQoLCfn3M.jpg","release_date":"2015-07-23","title":"Mission: Impossible - Rogue Nation","video":false,"vote_average":7.1,"vote_count":4198,"popularity":220.403],["adult":false,"backdrop_path":"/5qxePyMYDisLe8rJiBYX8HKEyv2.jpg","genre_ids":[28,12,53],"id":353081,"original_language":"en","original_title":"Mission: Impossible - Fallout","overview":"When an IMF mission ends badly, the world is faced with dire consequences. As Ethan Hunt takes it upon himself to fulfil his original briefing, the CIA begin to question his loyalty and his motives. The IMF team find themselves in a race against time, hunted by assassins while trying to prevent a global catastrophe.","poster_path":"/AkJQpZp9WoNdj7pLYSj1L0RcMMN.jpg","release_date":"2018-07-25","title":"Mission: Impossible - Fallout","video":false,"vote_average":7.6,"vote_count":200,"popularity":445.872]]]
        let collection = NetworkServices.shared.movieCollection(from: rawCollection)
        XCTAssertEqual(collection?.id, 87359)
        XCTAssertEqual(collection?.name, "Mission: Impossible Collection")
        XCTAssertEqual(collection?.parts?.count, 6)
    }
}
