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
end
