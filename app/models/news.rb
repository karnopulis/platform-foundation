require 'open-uri'
class News < ApplicationRecord
    
    
    def self.grab_show(url,announce)
        n =News.new
        html=open(url)
        doc = Nokogiri::HTML(html)
        doc.encoding = 'utf-8'
        nw =doc.css('.news_content')
        #puts nw
        n.title= nw.at_css("h3").text
        date= nw.css('.date_news').text
        n.created_at= DateTime.parse(date) if date.size>0 
        #puts nw.css('.news_body')
        body = nw.css('.news_body')
        if body.at_css("img")
            img = body.at_css("img").attributes['_fcksavedurl'].try(:remove)
            img_node =body.at_css("img").attributes['src']
            img = img_node.try(:value)
        #    puts img
            open('public/news/'+img.split("/").last, 'wb') do |file|
                file << open('http://www.prazdnikcom.ru'+img).read
            end
            body.at_css("img").attributes['src'].content='/news/'+img.split("/").last
        end
        
        ann= announce.at_css("iframe").try(:to_html)||""
        # if ann
        #     body.at_css('div').add_next_sibling ann.try(:content)
        # end
        n.text= ann+body.first.to_html
        n.brief="<a href="+url+" >source</a>"
        n.save
        
        
    end
    def self.grab_index(url)
       5.times do |i|
        html=open(url+"?p="+i.to_s)
        doc = Nokogiri::HTML(html)
        doc.encoding = 'utf-8'
        doc.css('.news').each do |ns|
            ann = ns.css(".announce")
            link = ns.css(".date").at_css("a").attributes['href'].value
            puts link
           News.grab_show('http://www.prazdnikcom.ru'+link,ann) 
        end
       end
    end
end
