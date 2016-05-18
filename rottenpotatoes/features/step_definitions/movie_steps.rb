# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table_hashes = movies_table.hashes
  @count = movies_table_hashes.length
  Movie.create(movies_table_hashes)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body).to match(/.*#{e1}.*#{e2}.*/m)
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
    steps %Q(When I #{uncheck}check "ratings_#{rating}")
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page).to have_selector("table tr", count: (Movie.count + 1))
end

Then /I should see the following movies: (.*)/ do |movie_list|
  movie_list.split(', ').each do |movie|
    steps %Q(Then I should see #{movie})
  end
end
  
Then /I should not see the following movies: (.*)/ do |movie_list|
  movie_list.split(', ').each do |movie|
    steps %Q(Then I should not see #{movie})
  end
end