class AddTestUsers < PhilColumns::Seed
  envs :development
  tags :default

  def up
    @users = [User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password'),
              User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password'),
              User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password'),
              User.create(email: Faker::Internet.email, password: 'password', password_confirmation: 'password') ]

    @users.each do |user|
      (5 + rand(10)).times do
        user.dm_log_entries.create(
          date_dmed:        Faker::Date.forward(365),
          date_played:      Faker::Date.forward(366),
          adventure_title:  'DDAL01-01 The Beginning',
          session_num:      Faker::Number.between(100, 10_000),
          xp_gained:        Faker::Number.between(200, 10_000),
          gp_gained:        Faker::Number.between(200, 10_000),
          downtime_gained:  10,
          renown_gained:    1,
          location_played:  'GenCon',
          notes: Faker::Company.bs )
      end
    end

    @users.each do |user|
      4.times do
        character = user.characters.create(name: Faker::Name.name )

        (5 + rand(10)).times do
          character.character_log_entries.create(
            date_played: Faker::Date.forward(365),
            adventure_title: 'DDAL01-01 The Beginning',
            session_num: Faker::Number.between(1, 10),
            xp_gained: Faker::Number.between(200, 10_000),
            gp_gained: Faker::Number.between(200, 10_000),
            renown_gained: 1,
            downtime_gained: 10,
            location_played: 'GenCon',
            dm_name: Faker::Name.name,
            dm_dci_number: Faker::Number.number(16),
            notes: Faker::Company.bs,
            num_secret_missions: Faker::Number.between(0, 1) )
        end

      end
    end

  end

  def down
  end

end
