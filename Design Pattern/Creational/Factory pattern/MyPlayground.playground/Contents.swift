lazy var downloadsSession: URLSession = {
      let configuration = URLSessionConfiguration.background(withIdentifier:
        "com.bgSession")
      return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
}()
