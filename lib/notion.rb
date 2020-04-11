class Notion
  def self.load_nested_cards(page_id)
    deck_pages = Notion.select_page_children(page_id, Notion.load_page_chunk(page_id))

    cards = {}
    deck_pages.each do |deck_id, data|
      next unless data["value"]["properties"]
      deck = data["value"]["properties"]["title"].flatten.first
      cards[deck] = {}

      full_data = self.load_page_chunk(deck_id)
      questions = self.select_page_children(deck_id, full_data)

      questions.each do |question_id, data|
        next unless data["value"]["properties"]

        question = data["value"]["properties"]["title"].flatten.first
        cards[deck][question] = []
        answers = select_page_children(question_id, full_data)

        answers.each do |answer_id, data|
          next unless data["value"]["properties"]
          cards[deck][question] =
            data["value"]["properties"]["title"].flatten.first
        end
      end
    end

    return cards
  end

  def self.load_page_chunk(page_id)
    uri = URI.parse("https://www.notion.so/api/v3/loadPageChunk")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Cookie"] = ENV.fetch("NOTION_TOKEN")
    request.body = JSON.dump({
      "pageId" => page_id,
      "limit" => 1000,
      "chunkNumber" => 0,
      "verticalColumns" => false
    })

    req_options = { use_ssl: uri.scheme == "https" }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  def self.select_page_children(page_id, data)
    (data.dig("recordMap", "block") || []).select { |_, v| v["value"]["parent_id"] == page_id }
  end
end
