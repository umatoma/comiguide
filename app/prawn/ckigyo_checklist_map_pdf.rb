class CkigyoChecklistMapPdf < Prawn::Document
  def initialize(comiket_id, user_id)
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

    @comiket_id = comiket_id
    @user_id = user_id
    @ckigyo_positions_hash = {}

    draw_header
    draw_content
    draw_footer
  end

  def draw_header
  end

  def draw_footer
    repeat(:all) do
      number_pages('<page> / <total>', align: :right, at: [bounds.right - 150, 0])
    end
  end

  def draw_content
    comiket = Comiket.includes(:ckigyos).find(@comiket_id)
    ckigyos = comiket.ckigyos
    ckigyo_checklists = comiket.ckigyo_checklists
      .includes(:ckigyo)
      .where(user_id: @user_id)

    define_grid(columns: comiket.kigyo_w, rows: comiket.kigyo_h, gutter: 0)

    ckigyos.each do |ckigyo|
      x = ckigyo.x
      y = ckigyo.y
      x2 = x + ckigyo.w - 1
      y2 = y + ckigyo.h - 1

      grid([y, x], [y2, x2]).bounding_box do
        transparent(0.5) { stroke_bounds }
        @ckigyo_positions_hash[ckigyo.id] = bounds_hash(bounds)
        text ckigyo.kigyo_no.to_s, align: :center, valign: :center
      end
    end

    ckigyo_checklists.each.with_index do |checklist, index|
      list_pos = {}
      y = 13 + index
      y2 = y
      list_datum = [
        { x: 10, x2: 10, text: checklist.ckigyo.kigyo_no.to_s },
        { x: 11, x2: 14, text: checklist.ckigyo.name },
        { x: 15, x2: 24, text: checklist.comment },
        { x: 25, x2: 27, text: checklist.cost },
        { x: 28, x2: 28, text: '' }
      ]
      list_datum.each.with_index do |data, i|
        grid([y, data[:x]], [y2, data[:x2]]).bounding_box do
          list_pos = bounds_hash(bounds) if i == 0
          transparent(0.5) { stroke_bounds }
          text data[:text], align: :center, valign: :center, overflow: :shrink_to_fit
        end
      end

      ckigyo_pos = @ckigyo_positions_hash[checklist.ckigyo_id]
      stroke do
        ckigyo = checklist.ckigyo
        line_x = line_ckigyo_x(ckigyo, ckigyo_pos[:absolute_left], ckigyo_pos[:right])
        line_y = line_ckigyo_y(ckigyo, ckigyo_pos[:absolute_bottom], ckigyo_pos[:top])
        line_x2 = line_list_x(list_pos[:absolute_left], list_pos[:right])
        line_y2 = line_list_y(list_pos[:absolute_bottom], list_pos[:top])
        line [line_x, line_y], [line_x2, line_y2]
      end
    end
  end

  private

  def bounds_hash(b)
    {
      top: bounds.top,
      bottom: bounds.bottom,
      right: bounds.right,
      left: bounds.left,
      absolute_top: bounds.absolute_top,
      absolute_bottom: bounds.absolute_bottom,
      absolute_right: bounds.absolute_right,
      absolute_left: bounds.absolute_left
    }
  end

  def line_ckigyo_y(ckigyo, absolute_bottom, top)
    box_bottom = absolute_bottom - (top - ckigyo.h + 1) / ckigyo.h
    box_top = box_bottom + top
    (box_top + box_bottom).to_f / 2.0 - ckigyo.h.to_f
  end

  def line_ckigyo_x(ckigyo, absolute_left, right)
    box_left = absolute_left - (right - ckigyo.w + 1) / ckigyo.w
    box_right = box_left + right
    (box_right + box_left).to_f / 2.0 + ckigyo.w.to_f
  end

  def line_list_y(absolute_bottom, top)
    box_bottom = absolute_bottom - top
    box_top = box_bottom + top
    (box_top + box_bottom).to_f / 2.0
  end

  def line_list_x(absolute_left, right)
    box_left = absolute_left - right
    box_right = box_left + right
    (box_right + box_left).to_f / 2.0
  end
end
