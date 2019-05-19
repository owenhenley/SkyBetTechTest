# SkyBetTechTest
https://github.com/skybet/native-tech-test


#### Thank you for taking the time to have a look at my tech test.

I used Codable and URLSession to fetch the JSON from a remote location. In my opinion, this is preferable since Codable was released, libraries such as SwiftyJSON and Alamofire are a little less relevant, and the less you depend on libraries the better (The Swift 5 change over was a good example as to why).

I would normally not store the Base URL in a .plist but because it was stored on my GitHub, this was the best way to 'hide' the URL.

I chose to Abstract and encapsulate as much as possible to keep on top of 'DRY' and stay consistent with the definition of encapsulation.

Now. Tests. I have only done very basic ones in my current workplace. And when more complex ones are done, we use a framework called 'Sourcery' and the company has an internal library that sets up most of the things needed for testing. I'm definitely interested in learning the ways of mocks and stubs. From what I understand, protocols are a great way of handling this.