struct DiscoveredItem {
    blog_url: String,
    post_url: String,
 }
 
 fn post_urls_from_blog<'a, 'b>(
    items: &'a [DiscoveredItem], 
    blog_url: &'b str,
 ) -> impl Iterator<Item = &'a str> + 'b 
 where 'a: 'b
 {
    // Creating an iterator from the &[DiscoveredItem] slice
    items.iter().filter_map(move |item| {
        // Filtering items by blog_url
        if item.blog_url == blog_url {
            // Returning a post URL
            Some(item.post_url.as_str())
        } else {
            None
        }
    })
 }
 fn main() {
     // Assume the crawler returned the following results
     let crawler_results = &[
         DiscoveredItem {
             blog_url: "https://blogs.com/".to_owned().to_owned(),
             post_url: "https://blogs.com/cooking/fried_eggs".to_owned(),
         },
         DiscoveredItem {
             blog_url: "https://blogs.com/".to_owned(),
             post_url: "https://blogs.com/travelling/death_mountain".to_owned(),
         },
         DiscoveredItem {
             blog_url: "https://successfulsam.xyz/".to_owned(),
             post_url: "https://successfulsam.xyz/keys_to_success/Just_do_this_one_thing_every_day".to_owned(),
         },
     ];
 
     // Reading the blog URL we're interested in from somewhere
     let blog_url = get_blog_url(); 
 
     // Collecting post URLs from this blog using our function
     let post_urls: Vec<_> = post_urls_from_blog(crawler_results, &blog_url).collect();
 
     // Spawning a thread to do some further blog processing
     let handle = std::thread::spawn(move || calculate_blog_stats(blog_url));
 
     // Processing posts in parallel
     for url in post_urls {
         process_post(url);
     }
 
     handle.join().expect("Everything will be fine");
 }
 
 // Returns a predefined value
 fn get_blog_url() -> String {
     "https://blogs.com/".to_owned()    
 }
 
 // Just prints URL out
 fn process_post(url: &str) {
     println!("{}", url);
 }
 
 // Actually does nothing
 fn calculate_blog_stats(_blog_url: String) {}
 