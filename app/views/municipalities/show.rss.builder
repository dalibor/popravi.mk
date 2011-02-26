xml.instruct!
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title "Листа на проблеми во општините во Македонија"
    xml.link problems_path(:format => 'rss')
    xml.description "Последно пријавени проблеми во општина #{@municipality.name}"
    xml.language "en-gb"
    for problem in @problems
      xml.item do
        xml.title problem.title
        xml.description problem.description
        xml.pubDate problem.created_at.to_s(:rfc822)
        xml.link problem_url(problem)
        xml.guid problem_url(problem)
      end
    end
  end
end
