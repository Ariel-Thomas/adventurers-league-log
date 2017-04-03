namespace :adventure_catalog do
  @adventure_catalog = 'lib/assets/Adventurers_League_Content_Catalog.pdf'
  ADVENTURE_CODES = ['DDAL', 'DDEN', 'DDEP', 'DDEX', 'DDHC', 'DDIA', 'DDLE', 'CCC']

  ADVENTURE_CODE_INDEX = 0
  ADVENTURE_HOURS_INDEX = 2
  ADVENTURE_TITLE_INDEX = 3

  IGNORE_HOURS_ENTRIES = ["Variable", "HC"]

  desc "Load adventure catalog from #{@adventure_catalog}"
  task :load => :environment do
    puts "*** BEGIN PARSING ADVENTURE CATALOG *** "
    reader = PDF::Reader.new(@adventure_catalog)

    reader.pages.each_with_index do |page, index|
      puts "*** BEGIN PAGE #{index + 1} ****"

      rows = page.text.split("\n")

      rows.select! do |row|
        has_code = false
        ADVENTURE_CODES.each do |code|
          if row.starts_with?(" #{code}")
            has_code = true
          end
        end

        has_code
      end

      if rows.count > 0
        puts "*** #{rows.count} Rows Found ****"
      else
        puts "SKIP PAGE"
        next
      end

      rows.each_with_index do |row, row_index|
        row = row.split(/  \s*/)

        unless row.length > 3
          if row.length == 3
            if row[2].include? 'Defiance in Phlan'
              row = [" DDEX1-1", "1-2", "5", "Defiance in Phlan"]
            elsif row[2].include? "Ark of the Mountains"
              row = [" DDEP05-02^", "1-4, 5-10, 11-16", "4", "The Ark of the Mountains"]
            else
              next
            end
          else
            next
          end
        end

        code = row[ADVENTURE_CODE_INDEX].strip.tr('^','').tr('*','')
        title = row[ADVENTURE_TITLE_INDEX].strip
        hours = row[ADVENTURE_HOURS_INDEX].partition(" ").first

        next if title.include?('Retired')

        IGNORE_HOURS_ENTRIES.each do |entry|
          hours = nil if hours == entry
        end

        adv = Adventure.where("name LIKE ?", "%#{title.strip}%").first
        adv = Adventure.where("name LIKE ?", "%#{code}%").first unless adv
        adv = Adventure.where("name LIKE ?", "%#{code.insert(4, '0')}%").first unless adv

        puts "Adding " + title.to_s unless adv

        position = index * 100 + row_index

        # puts "#{position} #{code} #{title}"

        if adv
          adv.update!(name: code + " " + title, hours: hours ? hours.to_i : nil, position_num: position)
        else
          Adventure.create!(name: code + " " + title, hours: hours ? hours.to_i : nil, position_num: position)
        end
      end

      puts "*** FINISH PAGE #{index + 1} ****"
    end
  end

  desc "Clean out chosen adventures"
  task :clean_dupes => :environment do
    adv = Adventure.find_by(name: 'DDEP03 Blood Above, Blood Below')
    adv.update!(name: 'DDEP3 Blood Above, Blood Below', position_num: 1002) if adv

     ["DDEX03-04 It's all in the Blood",
      "Storm King's Thunder",
      "DDEX1-03 Shadow on the Moonsea",
      "DDAL05-01 Treasure of the Broken Hoard",
      "DDAL05-09 Durlag's Tomb",
      'CORE2-1 Tales of Good and Evil',
      'PHLAN1-3  Subterfuge',
      'PHLAN1-2  Enemy of my Enemy',
      'PHLAN1-1  Sepulture',
      'HILL1-3 Resurgance',
      'ELM1-1  The Sage of Cormathor',
      'UCON-01 Blood and Fog',].each do |name|
        adv = Adventure.find_by(name: name)
        adv.destroy if adv
      end
  end
end
