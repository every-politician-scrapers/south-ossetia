#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Members
    decorator RemoveReferences
    decorator UnspanAllTables
    # decorator WikidataIdsDecorator::Links

    def member_container
      noko.xpath("//table[.//th[contains(.,'Должность')]]//tr[td]")
    end

    def member_items
      super.reject(&:empty?)
    end
  end

  class Member
    field :id do
      name_node.css('a/@wikidata').first
    end

    field :name do
      name_node.css('a').map(&:text).map(&:tidy).first
    end

    field :positionID do
    end

    field :position do
      tds[0].text.tidy
    end

    field :startDate do
      WikipediaDate::Russian.new(raw_start).to_s
    end

    field :endDate do
    end

    def empty?
      tds[1].text.include? 'вакантна'
    end

    private

    def tds
      noko.css('td')
    end

    def name_node
      tds[1]
    end

    def raw_start
      tds[2].text.tidy
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url).csv
