protocol CatClient {
    func fechCats() async throws  -> [Cat]
}
