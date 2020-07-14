class ImportController < ApplicationController
  def new
    @result = []
    spreadsheet = Roo::Spreadsheet.open params[:file]
    (1..spreadsheet.last_row).each do |i|
      response = spreadsheet.row(i)[1]
      
      @result << response
    end
    send_data @result.to_csv
  end

  def export
    @result = params[:result]
    respond_to do |format|
      format.html
      format.csv { send_data @result.to_csv }
    end
  end
end
