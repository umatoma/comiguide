class CcircleChecklistMapPdf < Prawn::Document
  def initialize(comiket_id, user_id, cmap_id, day)
    super(
      page_layout: :landscape,
      margin: 20,
      info: {
        Title: '企業ブースチェックリストマップ',
        Author: Settings.name_my,
        Subject: '',
        Keywords: 'コミケ コミックマーケット 企業ブース チェックリスト マップ PDF',
        Creator: Settings.name_my,
        Producer: Settings.site_name,
        CreationDate: Time.now
      }
    )

    font 'lib/assets/ipaexg.ttf'
    font_size 9

    comiket = Comiket.find(comiket_id)
    careas = Carea.where(cmap_id: cmap_id)
    cblocks = Cblock.includes(:clayouts).where(carea_id: careas.map(&:id))
    clayouts = Clayout.where(cblock_id: cblocks.map(&:id))
    ccircle_checklists = comiket.ccircle_checklists
      .includes(clayout: { cblock: :carea })
      .where(user_id: user_id)
      .where(day: day)
      .where(clayout_id: clayouts.map(&:id))

    ccircle_checklists.each_slice(12).with_index do |checklists, index|
      start_new_page unless index == 0
      draw_content(cblocks, clayouts, checklists)
    end
    draw_footer
  end

  def draw_footer
    text = "created by #{Settings.site_name} - #{Settings.site_url}  Page : <page> / <total>"
    number_pages(text, align: :right, at: [bounds.right - 300, 0])
  end

  def draw_content(cblocks, clayouts, ccircle_checklists)
    clayout_positions_hash = {}
    ccircle_w = 9
    ccircle_h = 5
    bounding_box([0, cursor], width: bounds.right, height: bounds.top * 0.8) do
      grid_x = clayouts.max_by(&:pos_x).scaled_pos_x + ccircle_w
      grid_y = clayouts.max_by(&:pos_y).scaled_pos_y + ccircle_h
      define_grid(columns: grid_x, rows: grid_y, gutter: 0)

      font_size 4
      checklist_layout_ids = ccircle_checklists.map(&:clayout_id).uniq
      clayouts.each do |clayout|
        x = clayout.scaled_pos_x
        y = clayout.scaled_pos_y
        grid([y, x], [y + ccircle_h, x + ccircle_w]).bounding_box do
          self.line_width = 0.3
          transparent(1.0) { stroke_bounds }
          if checklist_layout_ids.include?(clayout.id)
            clayout_positions_hash[clayout.id] = bounds_hash(bounds)
          end
          text clayout.space_no.to_s, align: :center, valign: :center
        end
      end
    end

    move_down 5

    bounding_box([0, cursor], width: bounds.right, height: bounds.top * 0.2 - 5.0) do
      define_grid(columns: 40, rows: 6, gutter: 0)
      font_size 8
      ccircle_checklists.each.with_index do |checklist, index|
        list_pos = {}
        if index < 6
          x_margin = 0
          y = y2 = index
        else
          x_margin = 20
          y = y2 = index - 6
        end
        list_datum = [
          { x: 0 + x_margin, x2: 1 + x_margin, text: checklist.clayout.layout_info_simple },
          { x: 2 + x_margin, x2: 7 + x_margin, text: checklist.circle_name },
          { x: 8 + x_margin, x2: 17 + x_margin, text: checklist.comment },
          { x: 18 + x_margin, x2: 19 + x_margin, text: checklist.cost }
        ]
        list_datum.each.with_index do |data, i|
          grid([y, data[:x]], [y2, data[:x2]]).bounding_box do
            list_pos = bounds_hash(bounds) if i == 0
            transparent(0.5) { stroke_bounds }
            text data[:text], align: :center, valign: :center, overflow: :shrink_to_fit
          end
        end

        clayout_pos = clayout_positions_hash[checklist.clayout_id]
        stroke do
          line_x = line_clayout_x(clayout_pos[:absolute_left], clayout_pos[:right])
          line_y = line_clayout_y(clayout_pos[:absolute_bottom], clayout_pos[:top])
          line_x2 = line_list_x(list_pos[:absolute_left], list_pos[:right])
          line_y2 = line_list_y(list_pos[:absolute_bottom], list_pos[:top])

          stroke_color checklist.color_hex
          line [line_x, line_y], [line_x2, line_y2]
        end
        stroke_color '000000'
      end
    end
  end

  private

  def bounds_hash(b)
    {
      top: b.top,
      bottom: b.bottom,
      right: b.right,
      left: b.left,
      absolute_top: b.absolute_top,
      absolute_bottom: b.absolute_bottom,
      absolute_right: b.absolute_right,
      absolute_left: b.absolute_left
    }
  end

  def line_clayout_y(absolute_bottom, top)
    box_bottom = absolute_bottom
    box_top = box_bottom + top
    (box_top + box_bottom).to_f / 2.0 - 20
  end

  def line_clayout_x(absolute_left, right)
    box_left = absolute_left
    box_right = box_left + right
    (box_right + box_left).to_f / 2.0 - 20
  end

  def line_list_y(absolute_bottom, top)
    box_bottom = absolute_bottom
    box_top = box_bottom + top
    (box_top + box_bottom).to_f / 2.0 - 20
  end

  def line_list_x(absolute_left, right)
    box_left = absolute_left
    box_right = box_left + right
    (box_right + box_left).to_f / 2.0 - 20
  end
end
