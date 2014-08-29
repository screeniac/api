[
  ['arclight hollywood',             {name: 'ArcLight Cinemas', scraper_ref: '1001'}],
  ['arclight pasadena',              {name: 'ArcLight Cinemas', scraper_ref: '1003'}],
  ['arclight beach cities',          {name: 'ArcLight Cinemas', scraper_ref: '1004'}],
  ['arclight sherman oaks',          {name: 'ArcLight Cinemas', scraper_ref: '1002', city: 'Sherman Oaks'}],
  ['arclight la jolla',              {name: 'ArcLight Cinemas', scraper_ref: '1005'}],
  ['new beverly cinema los angeles', {}],
  ['nuart theater los angeles',      {scraper_ref = '209'}]
].each do |(query, attributes)|
  venue = Venue.find_or_create_by_query(query, attributes)
  puts "- #{venue.name} (#{venue.city}) seeded"
end