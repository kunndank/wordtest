class WordsController < ApplicationController

  @@files = nil

  def index
  end

  def upload_and_execute_dict
    @@files = Word.fetch_unique_sequences(params[:file].path)
  end

  def download_sequence_file
    unless @@files.nil?
      file = File.open(@@files.first)
      send_file(file, :type => 'text')
    end
    render :index
  end

  def download_word_file
    unless @@files.nil?
      file = File.open(@@files.last)
      send_file(file, :type => 'text')
    end
    render :index
  end

end
