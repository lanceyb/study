#require "minitest/autorun"
require "spidr"

rs = []
Spidr.site("http://cngoldenview.com") do |spider|
  spider.every_page do |page|
    puts "[-] #{page.url}"
    page.search("//img").each do |img|
      src = img.attributes["src"]
      rs << src.value unless src.nil? || src =~ /gif|jpeg|jpg|png/
    end
  end
end

p rs.uniq
