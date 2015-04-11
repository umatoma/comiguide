namespace :comic1s do
  namespace :comic1_map_data do
    task comic1_9: :environment do
      Rake::Task["comic1s:comic1_map_data:execute"].invoke("9")
    end

    task :execute, [:comic1_id] => :environment do |task, args|
      comic1_id = args[:comic1_id]
      table = CSV.table(Rails.root.join("lib/tasks/files/comic1_#{comic1_id}_map.csv"))
      table.each do |row|
        space_no = row[:space_no]
        pos_x = row[:pos_x]
        pos_y = row[:pos_y]
        c1layout = C1layout
                   .joins(c1block: :comic1)
                   .where(space_no: space_no, pos_x: pos_x, pos_y: pos_y)
                   .where(comic1s: { id: comic1_id })
                   .first

        map_pos_x = row[:map_pos_x]
        map_pos_y = row[:map_pos_y]
        if c1layout.update(map_pos_x: map_pos_x, map_pos_y: map_pos_y)
          puts c1layout.attributes
        end
      end
    end
  end

  task comic1_9_circle_data: :environment do
    table = CSV.table(Rails.root.join('lib/tasks/comic1_9_circles.csv'))

    ActiveRecord::Base.transaction do
      comic1 = Comic1.find(9)
      table.each do |row|
        layout = C1layout
                 .joins(:c1block)
                 .where(c1blocks: { name: row[:block_name] })
                 .where(space_no: row[:space_no])
                 .first

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

  task comic1_9_layout_data: :environment do
    block_table = CSV.table(Rails.root.join('lib/tasks/comic1_9_blocks.csv'))
    layout_table = CSV.table(Rails.root.join('lib/tasks/comic1_9_layouts.csv'))
    ActiveRecord::Base.transaction do
      comic1 = Comic1.where(id: 9, event_no: 9, event_name: 'COMIC1☆9').first_or_create

      block_table.each do |row|
        c1block = C1block.new
        c1block.comic1 = comic1
        c1block.name = row[:name]
        c1block.pos_x = row[:pos_x]
        c1block.pos_y = row[:pos_y]
        c1block.save
      end

      layout_table.each do |row|
        c1block = C1block.find_by(comic1_id: 9, name: row[:name])
        c1layout = C1layout.new
        c1layout.c1block = c1block
        c1layout.space_no = row[:space_no]
        c1layout.pos_x = row[:pos_x]
        c1layout.pos_y = row[:pos_y]
        c1layout.save
      end
    end
  end
end
