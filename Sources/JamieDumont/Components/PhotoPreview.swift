
import Plot
import Publish

struct PhotoPreview<Site: Website>: Component {
    var item: Item<Site>
    var site: Site
    
    var body: Component {
        Link(url: item.path.absoluteString) {
            item.content.body
        }
    }
}
