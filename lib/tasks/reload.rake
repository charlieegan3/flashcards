require "digest"
require "net/http"
require "uri"
require "json"

require_relative '../../config/environment'
require_relative "../notion"

namespace :reload do
  task :cards do
    # track the current number of cards
    count = Card.count

    # list the digests of the current cards
    digests = []

    # for page under the collection, load the questions and answers
    Notion.load_nested_cards(ENV.fetch("NOTION_ROOT_PAGE")).each do |deck, cards|
      # for each card in each page (deck)
      cards.each do |question, answer|
        # skip/delete any without answers
        next if answer.blank?

        # generate the digest to test for identity and clearing up
        digests << Digest::MD5.hexdigest("#{deck} #{question} #{answer}")

        # create the card - matching on the digest to avoid dupes
        Card.find_or_create_by!(digest: digests.last).update(
          deck: deck,
          question: question,
          answer: answer
        )
      end
    end

    # clear out the old cards that have been removed from Notion
    Card.where.not(digest: digests).destroy_all

    # display the work down
    puts "before #{count}, after #{Card.count}"
  end
end
