# encoding:utf-8

require 'open-uri'
require 'nokogiri'

class ApplicationController < ActionController::Base

  protect_from_forgery
  
  helper_method :translate_jp_to_en

  def translate_jp_to_en(word_jp)
    
    # 日本語単語のItemIdを取得
    enc_word = URI.encode(word_jp)
    url = "http://public.dejizo.jp/NetDicV09.asmx/SearchDicItemLite?Dic=EdictJE&Word=#{enc_word}&Scope=HEADWORD&Match=EXACT&Merge=OR&Prof=XHTML&PageSize=20&PageIndex=0"
    xml = open(url).read
    doc = Nokogiri::XML(xml)
    item_id = doc.search('ItemID').first.inner_text rescue nil
    return "該当なし" unless item_id
    
    #日本語単語のItemIdから英単語を取得
    url = "http://public.dejizo.jp/NetDicV09.asmx/GetDicItemLite?Dic=EdictJE&Item=#{item_id}&Loc=&Prof=XHTML"
    xml = open(url).read
    doc = Nokogiri::XML(xml)
    text = doc.search('Body').inner_text rescue nil
    text.gsub!(/(\r\n|\r|\n|\t|\s)/, '')
    text.delete!("(n)").delete!("(P)")
    return text
  end
end
