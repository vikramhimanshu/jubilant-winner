//
//  MyNewsReaderTests.swift
//  MyNewsReaderTests
//
//  Created by Himanshu T on 14/4/21.
//

import XCTest
@testable import MyNewsReader

class MyNewsReaderTests: XCTestCase {
    
    var presenter: Presenter?
    var serverData: Data?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        presenter = Presenter()
        if let url = Bundle.main.url(forResource: "ServerResponse", withExtension: nil) {
            serverData = try Data(contentsOf: url)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        serverData = nil
    }

    func testBasicWebServiceUrlGeneration() {
        let endpoint = XMLToJSONEndPoint.abcNewsFeed()
        XCTAssertEqual(endpoint.url, URL(string: "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"))
    }
    
    func testCellIdentifierForFeaturedItem() {
        let indexPath = IndexPath(row: 0, section: 0)
        let identifier = presenter?.identifierForNewsItemCell(for: indexPath)
        XCTAssertEqual(identifier, "newsItemLarge")
    }
    
    func testCellIdentifierForOtherItem() {
        let indexPath = IndexPath(row: 1, section: 0)
        let identifier = presenter?.identifierForNewsItemCell(for: indexPath)
        XCTAssertEqual(identifier, "newsItemSmall")
    }
    
    func testCellIdentifierForOtherItem2() {
        let indexPath = IndexPath(row: 2, section: 0)
        let identifier = presenter?.identifierForNewsItemCell(for: indexPath)
        XCTAssertEqual(identifier, "newsItemSmall")
    }
    
    func testNumberOfArticlesInServerResponse() throws {
        if let data = serverData {
            let feed:RssRoot = try JSONDecoder().decode(RssRoot.self, from: data)
            XCTAssertEqual(feed.items.count, 10)
        }
    }
    
    func testIfServerResponseIsAValidJSON() throws {
        if let data = serverData {
            let j = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            XCTAssert(JSONSerialization.isValidJSONObject(j))
        }
    }
    
    func testIfServerResponseIsNotAValidJSON() throws {
        if let url = Bundle.main.url(forResource: "InValidServerReponse", withExtension: nil) {
            let data = try Data(contentsOf: url)
            XCTAssertThrowsError(try JSONSerialization.jsonObject(with: data, options: .allowFragments))
        }
    }

}
