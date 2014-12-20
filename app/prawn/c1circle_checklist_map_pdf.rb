class C1circleChecklistMapPdf < Prawn::Document
  include ActiveModel::Validations

  attr_accessor :comic1_id, :user_id, :draw_line

  validates :comic1_id, presence: true, numericality: true
  validates :user_id,    presence: true, numericality: true

  def initialize(attributes = {})
    super(
      page_layout: :landscape,
      margin: 20,
      info: {
        Title: 'COMIC1サークルチェックリストマップ',
        Author: Settings.name_my,
        Subject: '',
        Keywords: 'COMIC1 チェックリスト マップ PDF',
        Creator: Settings.name_my,
        Producer: Settings.site_name,
        CreationDate: Time.now
      }
    )

    font 'lib/assets/ipaexg.ttf'
    font_size 9

    attributes.each do |name, value|
      send("#{name}=", value)
    end

    comic1 = Comic1.includes(:c1blocks, :c1layouts).find(comic1_id)
    c1blocks = comic1.c1blocks
    c1layouts = comic1.c1layouts
    c1circle_checklists = comic1.c1circle_checklists
      .includes(c1layout: :c1block)
      .where(user_id: user_id)

    if c1circle_checklists.blank?
      draw_content_east(c1blocks, c1layouts, [])
    else
      c1circle_checklists.each_slice(12).with_index do |checklists, index|
        start_new_page unless index == 0
        draw_content_east(c1blocks, c1layouts, checklists)
      end
    end
    draw_footer
  end

  def draw_footer
    text = "created by #{Settings.site_name} - #{Settings.site_url}  Page : <page> / <total>"
    number_pages(text, align: :right, at: [bounds.right - 300, 0])
  end

  def draw_content_east(c1blocks, c1layouts, c1circle_checklists)
    c1layout_positions_hash = {}
    box_scale = 0.8

    bounding_box([0, bounds.top], width: bounds.right, height: bounds.top * box_scale) do
      grid_x = c1layouts.max_by(&:pos_x).pos_x + 1
      grid_y = c1layouts.max_by(&:pos_y).pos_y + 2
      define_grid(columns: grid_x, rows: grid_y, gutter: 0)

      font_size 4
      checklist_layout_ids = c1circle_checklists.map(&:c1layout_id).uniq
      c1layouts.each do |c1layout|
        x = c1layout.pos_x
        y = c1layout.pos_y
        grid([y, x], [y, x]).bounding_box do
          self.line_width = 0.3
          transparent(1.0) { stroke_bounds }
          if checklist_layout_ids.include?(c1layout.id)
            c1layout_positions_hash[c1layout.id] = bounds_hash(bounds)
          end
          text c1layout.space_no.to_s, align: :center, valign: :center
        end
      end

      font_size 8
      c1blocks.each do |c1block|
        x = c1block.pos_x
        y = c1block.pos_y
        x2 = x + 1
        y2 = y + 1
        grid([y, x], [y2, x2]).bounding_box do
          text c1block.name, align: :center, valign: :center
        end
      end
    end

    move_down 5
    list_box_x = 0
    list_box_y = cursor
    list_box_w = bounds.right
    list_box_h = bounds.top * 0.2 - 5.0
    columns = 40
    rows = 6

    bounding_box([list_box_x, list_box_y], width: list_box_w, height: list_box_h - 5) do
      define_grid(columns: columns, rows: rows, gutter: 0)
      font_size 8
      c1circle_checklists.each.with_index do |checklist, index|
        list_pos = {}
        if index < 6
          x_margin = 0
          y = y2 = index
        else
          x_margin = 20
          y = y2 = index - 6
        end
        list_datum = [
          { x: 0 + x_margin, x2: 1 + x_margin, text: checklist.layout_info_simple },
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

        next unless draw_line?
        c1layout_pos = c1layout_positions_hash[checklist.c1layout_id]
        stroke do
          line_x = line_c1layout_x(c1layout_pos[:absolute_left], c1layout_pos[:right])
          line_y = line_c1layout_y(c1layout_pos[:absolute_bottom], c1layout_pos[:top])
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

  def line_c1layout_y(absolute_bottom, top)
    box_bottom = absolute_bottom
    box_top = box_bottom + top
    margin = 20
    (box_top + box_bottom).to_f / 2.0 - margin
  end

  def line_c1layout_x(absolute_left, right)
    box_left = absolute_left
    box_right = box_left + right
    margin = 20
    (box_right + box_left).to_f / 2.0 - margin
  end

  def line_list_y(absolute_bottom, top)
    box_bottom = absolute_bottom
    box_top = box_bottom + top
    margin = 20
    (box_top + box_bottom).to_f / 2.0 - margin
  end

  def line_list_x(absolute_left, right)
    box_left = absolute_left
    box_right = box_left + right
    margin = 20
    (box_right + box_left).to_f / 2.0 - margin
  end

  def draw_line?
    draw_line == 'true'
  end
end
