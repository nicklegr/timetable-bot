# coding: utf-8

require 'pp'
require 'redcloth'
require 'nokogiri'
require 'cgi'

class Parser
  REPLACE = [
    [ /\n/, ' ' ],
    [ /^　+/, '' ],
    [ /　+$/, '' ],
  ]

  def self.parse(doc)
    timetable = []

    html = RedCloth.new(doc).to_html
    doc = Nokogiri::HTML(html)

    doc.css('tr').each do |row|
      cols = row.css('td').map{|e| e.inner_text }

      cols.map! do |e|
        s = e
        REPLACE.each do |entry|
          s = s.gsub(entry[0], entry[1])
        end
        s.strip
      end

      cols.reject!{|e| e.empty? }

      if cols.size >= 2
        time_col = cols[0].tr('０-９：', '0-9:')
        if time_col.match(/(\d+:\d+)/)
          time_str = $1
          title = cols[1 .. -1].join(' / ')

          timetable << [time_str, title]
        end
      end
    end

    timetable
  end
end
