require 'date'
class PostsController < ApplicationController


  def create
    spreadsheet = Roo::Spreadsheet.open params[:file]
    debugger
    @result = []
    (1..spreadsheet.last_row).each do |i|
      name = spreadsheet.row(i)[1]
      a = HTTParty.get("https://insta-scraper-app.herokuapp.com/fetch-medias?username=#{name}&end_cursor=").parsed_response
      next_page = true
      while next_page == true
        next_page = a['data']['user']['edge_owner_to_timeline_media']['page_info']['has_next_page']
        posts = a['data']['user']['edge_owner_to_timeline_media']['edges']
        posts.each do |post|
          like = post['node']['edge_liked_by']['count']
          time_stamp = post['taken_at_timestamp']
          time = DateTime.strptime(time_stamp,'%s')
          if like > 5000 && time >= params[:time]
            url = post['node']['shortcode']
            @result << url
          end
        end
        cursor = a['data']['user']['edge_owner_to_timeline_media']['page_info']['end_cursor']
        a = HTTParty.get("https://insta-scraper-app.herokuapp.com/fetch-medias?username=#{name}&end_cursor=#{cursor}").parsed_response
      end
    end
    send_data @result.to_csv
  end

end
