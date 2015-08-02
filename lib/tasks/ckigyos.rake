namespace :ckigyos do
  # bin/rake ckigyos:create_comiket_map[88]
  task :create_comiket_map, [:comiket_id] => :environment do |task, args|
    comiket_id = args[:comiket_id].to_i

    ActiveRecord::Base.transaction do
      table = CSV.table(Rails.root.join("lib/tasks/files/ckigyos_#{comiket_id}_map.csv"))
      table.each do |row|
        kigyo_no = row[:kigyo_no]
        ckigyo = Ckigyo.find_by(comiket_id: comiket_id, kigyo_no: kigyo_no)

        map_pos_x = row[:map_pos_x]
        map_pos_y = row[:map_pos_y]
        if ckigyo.update(map_pos_x: map_pos_x, map_pos_y: map_pos_y)
          puts ckigyo.attributes
        end
      end
    end
  end

  task comiket_87_map_data: :environment do
    table = CSV.table(Rails.root.join('lib/tasks/ckigyos_87_map.csv'))
    table.each do |row|
      kigyo_no = row[:kigyo_no]
      ckigyo = Ckigyo.find_by(comiket_id: 87, kigyo_no: kigyo_no)

      map_pos_x = row[:map_pos_x]
      map_pos_y = row[:map_pos_y]
      if ckigyo.update(map_pos_x: map_pos_x, map_pos_y: map_pos_y)
        puts ckigyo.attributes
      end
    end
  end
end
