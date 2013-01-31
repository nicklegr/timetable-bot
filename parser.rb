# coding: utf-8

require 'pp'
require 'redcloth'
require 'cgi'

class Parser
  NOISE = [
    /<[^>]+>/,
    /\\\d./,
    /^　+/,
    /　+$/,
  ]

  # @todo RedCloth -> Nokogiriのコンボのほうがロバストになりそう
  def self.parse(doc)
    timetable = []

    doc.each_line do |line|
      cols = parse_row(line)
      if cols
        # @todo 全角数字
        if cols[0].match(/(\d+[:：]\d+)/)
          time_str = $1.gsub('：', ':')
          title = cols[1 .. -1].join(' ')

          timetable << [time_str, title]
        end
      end
    end

    timetable
  end

  def self.parse_row(str)
    return unless str.index('|')

    cols = str.split(/\s*\|\s*/)

    cols.map! do |e|
      s = RedCloth.new(e).to_html

      NOISE.each do |re|
        s = s.gsub(re, '')
      end

      s = CGI.unescape_html(s)
      s.strip
    end

    cols.reject!{|e| e.empty? }

    if cols.size >= 1
      cols
    else
      nil
    end
  end
end