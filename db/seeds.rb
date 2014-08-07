[
  ['arclight hollywood',             {scraper_ref: '1001'}],
  ['arclight pasadena',              {scraper_ref: '1003'}],
  ['arclight beach cities',          {scraper_ref: '1004'}],
  ['arclight sherman oaks',          {scraper_ref: '1002'}],
  ['arclight la jolla',              {scraper_ref: '1005'}],
  ['new beverly cinema los angeles', {}],
  ['nuart theater los angeles',      {}]
].each do |(query, attributes)|
  venue = Venue.find_or_create_by_query(query, attributes)
  puts "- #{venue.name} (#{venue.city}) seeded"
end