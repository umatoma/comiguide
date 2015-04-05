namespace :comic1s do
  task comic1_8_map_data: :environment do
    table = CSV.table(Rails.root.join('lib/tasks/comic1_8_map.csv'))
    table.each do |row|
      space_no = row[:space_no]
      pos_x = row[:pos_x]
      pos_y = row[:pos_y]
      c1layout = C1layout
                 .joins(c1block: :comic1)
                 .where(space_no: space_no, pos_x: pos_x, pos_y: pos_y)
                 .where(comic1s: { id: 8 })
                 .first

      map_pos_x = row[:map_pos_x]
      map_pos_y = row[:map_pos_y]
      if c1layout.update(map_pos_x: map_pos_x, map_pos_y: map_pos_y)
        puts c1layout.attributes
      end
    end
  end

  task comic1_9_circle_data: :environment do
    table = CSV.table(Rails.root.join('lib/tasks/comic1_9_circles.csv'))

    ActiveRecord::Base.transaction do
      comic1 = Comic1.where(id: 9, event_no: 9, event_name: 'COMIC1☆9').first_or_create
      table.each do |row|
        # block_name,space_no,space_no_sub,circle_name,circle_kana,url
        block = C1block
                .where(comic1_id: comic1.id)
                .where(name: row[:block_name])
                .first_or_create

        layout = C1layout
                 .where(c1block_id: block.id)
                 .where(space_no: row[:space_no])
                 .first_or_create

        circle = C1circle.new
        circle.comic1 = comic1
        circle.c1layout = layout
        circle.space_no_sub = row[:space_no_sub]
        circle.name = row[:circle_name]
        circle.kana = row[:circle_kana]
        circle.url = row[:url] if row[:url].present?
        circle.save
      end
    end
  end
end
