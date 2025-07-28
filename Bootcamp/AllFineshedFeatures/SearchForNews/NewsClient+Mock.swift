import Foundation

final class NewsClientMock: NewsClient {
    func fetchNews(for search: String) async throws -> NewsResults {
        let mockArticles = [
            Article(
                source: Source(
                    id: "1", 
                    name: "Canal+"
                ), 
                author: "",
                title: "Top Stock Movers Now: Deckers, Tesla, Intel, and More",
                description: "In This Article:\nMajor U.S. equities indexes advanced at midday, with the S&P 500 on track to set a record high every day this week, after a slew of strong earnings reports and amid optimism about U.S. trade deals. The Dow and Nasdaq also gained.\nUgg and Hoka…",
                url: "https://biztoc.com/x/6c01029498b3b57c",
                urlToImage: "https://biztoc.com/cdn/6c01029498b3b57c_s.webp",
                content: "In This Article:Major U.S. equities indexes advanced at midday, with the S&amp;P 500 on track to set a record high every day this week, after a slew of strong earnings reports and amid optimism about… [+154 chars]"
            ),
            Article(
                source: Source(
                    id: "2", 
                    name: "Forbes"
                ), 
                author: "Forbes Staff",
                title:"Tesla supera a sus rivales chinos en algunas pruebas de conducción autónoma",
                description: "Forbes México.\n Tesla supera a sus rivales chinos en algunas pruebas de conducción autónoma\n\nLa televisión estatal CCTV y Dcar probaron conjuntamente los sistemas avanzados de asistencia a la conducción (ADAS) de nivel 2 de más de 20 marcas de vehículos eléct…",
                url: "https://forbes.com.mx/tesla-supera-a-sus-rivales-chinos-en-algunas-pruebas-de-conduccion-autonoma/",
                urlToImage: "https://cdn.forbes.com.mx/2023/02/tesla-0005.webp",
                content: "Tesla, de Elon Musk, superó a rivales chinos como BYD, Xiaomi y Huawei en una prueba de tecnologías de conducción asistida en carreteras chinas, señalan los resultados publicados por Dcar, la unidad … [+4245 chars]"
            ),
        ]
        return NewsResults(status: "ok", totalResults: 2, articles: mockArticles)
    }
}
