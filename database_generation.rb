## DATABASE GENERATOR ###

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require './sinatrastudents'


INDEX = "http://students.flatironschool.com/"
INDEX_DOC = Nokogiri::HTML(open(INDEX))

student_urls = INDEX_DOC.css("div.one_third > a").map do |a| 
    (INDEX + a.attr("href")).sub("/.", "" )
end

def student_scraper(student_urls)
  student_urls.each do |student|
    begin
    hella_student = Student.new
    hella_student.scrape_and_insert(student)
      hella_student.save
      "Success!"
    rescue => e
      puts "Error creating #{student}: #{e}"
      next
    end
  end
end

student_scraper(student_urls)