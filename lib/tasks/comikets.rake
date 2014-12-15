namespace :comikets do
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
