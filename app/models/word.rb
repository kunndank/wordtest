class Word

  def self.fetch_unique_sequences(file_path="public/sample.txt")
    sequences = Hash.new { |h,k| h[k] = [] }

    # Read the input dictionary file from the path
    File.foreach(file_path) do |e|
      word = e.strip
      next if word.length < 4

      # To fetch all the 4 lettered sequences from the word
      (0..word.length - 4).each do |i|
        sequence = word[i, 4] if (word[i,4][/\W/].nil? && !(word[i, 4].count("0-9") > 0))
        sequences[sequence] << word unless sequences[sequence].include?(word)
      end
    end

    # To fetche all the sequence appearing in one word only
    unique_sequences = sequences.select { |_, words| words.size == 1 }

    # Creates files for the unique sequences and their corresponding words seperately
    sequence_file = File.new("sequences_#{DateTime.now}.txt", "w")
    word_file = File.new("words_#{DateTime.now}.txt", "w")

    unique_sequences.each do |sequence, words|
      puts "#{sequence}: #{words.first}"
      sequence_file.puts("#{sequence}")
      word_file.puts("#{words.first}")
    end

    sequence_file.close()
    word_file.close()

    return [sequence_file, word_file]
  end
end
