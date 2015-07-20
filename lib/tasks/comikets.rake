namespace :comikets do
  task :create_ckigyos, [:comiket_id] => :environment do |task, args|
    comiket_id = args[:comiket_id].to_i
    unless Comiket.exists?(id: comiket_id)
      Comiket.create!(id: comiket_id, event_no: comiket_id, event_name: "C#{comiket_id}", kigyo_w: 30, kigyo_h: 36)
    end
    comiket = Comiket.find(comiket_id)

    ActiveRecord::Base.transaction do
      csv = CSV.parse(File.read(Rails.root.join("lib/tasks/files/ckigyos_c#{comiket.id}.csv")), headers: false)
      csv.each do |row|
        kigyo_no = row[0].to_i
        name = row[1]
        x = 0
        y = 0
        w = 0
        h = 0
        ckigyo = Ckigyo.new(comiket_id: comiket.id, kigyo_no: kigyo_no, name: name, x: x, y: y, w: w, h: h)
        ckigyo.save!
      end
    end
  end

  task :create_ckigyo_links, [:comiket_id] => :environment do |task, args|
    comiket_id = args[:comiket_id].to_i
    unless Comiket.exists?(id: comiket_id)
      Comiket.create!(id: comiket_id, event_no: comiket_id, event_name: "C#{comiket_id}", kigyo_w: 30, kigyo_h: 36)
    end
    comiket = Comiket.find(comiket_id)

    ActiveRecord::Base.transaction do
      csv = CSV.parse(File.read(Rails.root.join("lib/tasks/files/ckigyo_links_c#{comiket.id}.csv")), headers: false)
      csv.each do |row|
        ckigyo_link = CkigyoLink.new
        ckigyo_link.ckigyo = Ckigyo.where(comiket_id: comiket.id, kigyo_no: row[0].to_i).first
        ckigyo_link.url = row[1]
        ckigyo_link.save!
      end
    end
  end

  task create_c87: :environment do
    ActiveRecord::Base.transaction do
      Comiket.create!(id: 87, event_no: 87, event_name: 'C87', kigyo_w: 30, kigyo_h: 36)
      csv = CSV.parse(File.read(Rails.root.join('lib/tasks/ckigyos_c87.csv')), headers: true, col_sep: '`')
      csv.each do |row|
        kigyo_no = row[2].to_i
        name = row[3]
        x = row[4].to_i
        y = row[5].to_i
        w = row[6].to_i
        h = row[7].to_i
        ckigyo = Ckigyo.new(comiket_id: 87, kigyo_no: kigyo_no, name: name, x: x, y: y, w: w, h: h)
        ckigyo.save!
      end
    end
  end

  task create_ckigyo_links_c87: :environment do
    ActiveRecord::Base.transaction do
      ckigyos = Ckigyo.where(comiket_id: 87)
      csv = CSV.parse(File.read('lib/tasks/ckigyo_links_c87.csv'), headers: false)
      csv.each do |row|
        ckigyo_link = CkigyoLink.new
        ckigyo_link.ckigyo_id = ckigyos.find { |x| x.kigyo_no == row[0].to_i }.id
        ckigyo_link.url = row[1]
        ckigyo_link.save!
      end
    end
  end
end
