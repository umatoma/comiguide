require 'csv'

namespace :create_data do
  task all: [
    :comikets,
    :ckigyos,
    :ckigyo_links,
    :ckigyo_checklists,
    :careas,
    :cblocks,
    :clayouts,
    :ccircle_checklists]

  task users: :environment do
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/users.csv')), headers: true, col_sep: "`")
    User.transaction do
      csv.each do |row|
        next if row.size == 0
        password = SecureRandom.hex(8)
        username = /\A\w+@undefined\z/.match(row[4]) ? "backup_#{row[1]}" : row[1]
        updated_at = row[10].to_i.zero? ? Time.at(row[9].to_i) : Time.at(row[10].to_i)
        attributes = {
          id: row[0].to_i,
          username: username,
          email: row[4],
          created_at: Time.at(row[9].to_i),
          updated_at: updated_at,
          password: password
        }
        user = User.new(attributes)
        user.skip_confirmation!
        user.save!
        puts "id: #{user.id}, password: #{password}"
      end
    end
  end

  task comikets: :environment do
    Comiket.transaction do
      Comiket.new(id: 83, event_no: 83, event_name: :C83, kigyo_w: 29, kigyo_h: 36).save!
      Comiket.new(id: 84, event_no: 84, event_name: :C84, kigyo_w: 29, kigyo_h: 36).save!
      Comiket.new(id: 85, event_no: 85, event_name: :C85, kigyo_w: 29, kigyo_h: 36).save!
    end
  end

  task ckigyos: :environment do
    comikets = Comiket.all
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/ckigyos.csv')), headers: false, col_sep: "`")
    Ckigyo.transaction do
      csv.each do |row|
        next if row.size == 0
        comiket = comikets.find { |x| x.event_no == row[1].to_i }
        attributes = {
          comiket_id: comiket.id,
          kigyo_no: row[2],
          name: row[3],
          x: row[4],
          y: row[5],
          w: row[6],
          h: row[7]
        }
        Ckigyo.new(attributes).save!
      end
    end
  end

  task ckigyo_links: :environment do
    comikets = Comiket.all
    ckigyos = Ckigyo.all
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/ckigyo_links.csv')), headers: false, col_sep: "`")
    Ckigyo.transaction do
      csv.each do |row|
        next if row.size == 0
        comiket = comikets.find { |x| x.event_no == row[1].to_i }
        ckigyo = ckigyos.find { |x| x.comiket_id == comiket.id && x.kigyo_no == row[2].to_i }
        attributes = {
          ckigyo_id: ckigyo.id,
          url: row[3]
        }
        CkigyoLink.new(attributes).save!
      end
    end
  end

  task ckigyo_checklists: :environment do
    ckigyos = Ckigyo.all
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/ckigyo_checklists.csv')), headers: false, col_sep: "`")
    Ckigyo.transaction do
      csv.each do |row|
        next if row.size == 0
        ckigyo = ckigyos.find { |x| x.comiket_id == row[2].to_i && x.kigyo_no == row[3].to_i }
        attributes = {
          user_id: row[1].to_i,
          ckigyo_id: ckigyo.id,
          comment: row[4],
          cost: row[5],
          color: row[6],
          rank: row[7].to_i
        }
        CkigyoChecklist.new(attributes).save!
      end
    end
  end

  task careas: :environment do
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/careas.csv')), headers: true)
    Carea.transaction do
      csv.each do |row|
        next if row.size == 0
        attributes = {
          id: row[0].to_i,
          cmap_id: row[3].to_i,
          name: row[1],
          simple_name: row[2],
          all_file_name: row[8],
          pos_x: row[4].to_i,
          pos_y: row[5].to_i,
          size_w: row[6].to_i,
          size_h: row[7].to_i,
          pos_x2: row[9].to_i,
          pos_y2: row[10].to_i,
          size_w2: row[11].to_i,
          size_h2: row[12].to_i
        }
        Carea.new(attributes).save!
      end
    end
  end

  task cblocks: :environment do
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/cblocks.csv')), headers: true)
    Cblock.transaction do
      csv.each do |row|
        next if row.size == 0
        attributes = {
          id: row[0].to_i,
          carea_id: row[2].to_i,
          name: row[1],
          pos_x: row[3].to_i,
          pos_y: row[4].to_i
        }
        Cblock.new(attributes).save!
      end
    end
  end

  task clayouts: :environment do
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/clayouts.csv')), headers: true)
    Clayout.transaction do
      csv.each do |row|
        next if row.size == 0
        attributes = {
          id: row[0].to_i,
          cblock_id: row[1].to_i,
          space_no: row[2].to_i,
          layout: row[5].to_i,
          pos_x: row[3].to_i,
          pos_y: row[4].to_i
        }
        Clayout.new(attributes).save!
      end
    end
  end

  task ccircle_checklists: :environment do
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/ccircle_checklists.csv')), headers: true, col_sep: "`")
    CcircleChecklist.transaction do
      csv.each do |row|
        next if row.size == 0
        clayout = Clayout.find_by(cblock_id: row[4].to_i, space_no: row[5].to_i)
        attributes = {
          id: row[0].to_i,
          user_id: row[1].to_i,
          comiket_id: row[2].to_i,
          clayout_id: clayout.id,
          day: row[3].to_i,
          circle_name: row[6],
          circle_url: row[7],
          comment: row[8],
          cost: row[9],
          created_at: Time.at(row[11].to_i),
          updated_at: Time.at(row[12].to_i)
        }
        CcircleChecklist.new(attributes).save!
      end
    end
  end

  task comic1s: :environment do
    Comic1.transaction do
      Comic1.new(id: 6, event_no: 6, event_name: 'COMIC1☆6').save!
      Comic1.new(id: 7, event_no: 7, event_name: 'COMIC1☆7').save!
      Comic1.new(id: 8, event_no: 8, event_name: 'COMIC1☆8').save!
    end
  end

  task c1blocks: :environment do
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1blocks.csv')), headers: true, col_sep: "`")
    C1block.transaction do
      csv.each do |row|
        next if row.size == 0
        attributes = {
          comic1_id: row[1].to_i,
          name: row[2],
          pos_x: row[3].to_i - 1,
          pos_y: row[4].to_i - 2
        }
        C1block.new(attributes).save!
      end
    end
  end

  task c1layouts: :environment do
    c1block_ids = {}
    index = 1
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1blocks.csv')), headers: true, col_sep: "`")
    csv.each do |row|
      c1block_ids[row[0].to_i] = index
      index += 1
    end

    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1layouts.csv')), headers: true, col_sep: "`")
    C1layout.transaction do
      csv.each do |row|
        next if row.size == 0
        attributes = {
          c1block_id: c1block_ids[row[2].to_i],
          space_no: row[3].to_i,
          layout: 1,
          pos_x: row[4].to_i - 1,
          pos_y: row[5].to_i - 2
        }
        C1layout.new(attributes).save!
      end
    end
  end

  task c1circles: :environment do
    c1block_ids = {}
    index = 1
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1blocks.csv')), headers: true, col_sep: "`")
    csv.each do |row|
      c1block_ids[row[0].to_i] = index
      index += 1
    end

    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1circles.csv')), headers: true, col_sep: "`")
    C1circle.transaction do
      csv.each do |row|
        next if row.size == 0
        c1layout = C1layout.find_by(c1block_id: c1block_ids[row[5].to_i], space_no: row[6].to_i)
        attributes = {
          id: row[0].to_i,
          comic1_id: row[1].to_i,
          c1layout_id: c1layout.id,
          space_no_sub: row[7].to_i,
          name: row[2],
          kana: row[3],
          url: row[4] == 'NULL' ? nil : row[4],
          created_at: Time.at(row[8].to_i),
          updated_at: Time.at(row[9].to_i)
        }
        C1circle.new(attributes).save!
      end
    end
  end

  task c1circle_checklists: :environment do
    c1block_ids = {}
    index = 1
    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1blocks.csv')), headers: true, col_sep: "`")
    csv.each do |row|
      c1block_ids[row[0].to_i] = index
      index += 1
    end

    csv = CSV.parse(File.read(Rails.root.join('lib/tasks/c1circle_checklists.csv')), headers: true, col_sep: "`")
    C1circleChecklist.transaction do
      csv.each do |row|
        next if row.size == 0
        c1layout = C1layout.find_by(c1block_id: c1block_ids[row[3].to_i], space_no: row[4].to_i)
        attributes = {
          user_id: row[1].to_i,
          comic1_id: row[2].to_i,
          c1layout_id: c1layout.id,
          space_no_sub: row[5].to_i,
          circle_name: row[6].present? ? row[6] : 'null',
          circle_url: row[7],
          comment: row[8],
          cost: row[9],
          color: row[10],
          rank: row[11].to_i,
          created_at: Time.at(row[12].to_i),
          updated_at: Time.at(row[13].to_i)
        }
        C1circleChecklist.new(attributes).save!
      end
    end
  end
end
