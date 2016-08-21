class AddSeason5Adventures < PhilColumns::Seed

  envs :test, :development, :production
  tags :default

  def up
    season5_adventures =
                 ["Storm King's Thunder",
                  "DDIA05 A Great Upheaval Introductory Adventure",
                  "DDEP05-01 The Iron Baron",
                  "DDEP05-02 The Ark of the Mountains",
                  "DDAL05-01 Treasure of the Broken Hoard",
                  "DDAL05-02 The Black Road",
                  "DDAL05-03 Uninvited Guests",
                  "DDAL05-04 In Dire Need",
                  "DDAL05-05 A Dish Best Served Cold",
                  "DDAL05-06 Beneath the Fetid Chelimber",
                  "DDAL05-07 Chelimber’s Descent",
                  "DDAL05-08 Beneath Durlag’s Tower",
                  "DDAL05-09 Beneath Durlag’s Tower pt2",
                  "DDAL05-10 Giant Diplomacy"]

    season5_adventures.each do |adventure|
      AdventureFormInput.find_or_create_by(name: adventure)
    end
  end

  def down
  end
end
