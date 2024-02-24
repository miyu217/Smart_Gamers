module ApplicationHelper
  def display_rating_icon(rating)
    case rating
    when 1
      content_tag(:i, ' Poor', class: 'fa-solid fa-face-sad-tear')
    when 2
      content_tag(:i, ' Below Average"', class: 'fa-solid fa-face-frown-open')
    when 3
      content_tag(:i, ' Average', class: 'fa-solid fa-face-meh')
    when 4
      content_tag(:i, ' Good', class: 'fa-solid fa-face-smile')
    when 5
      content_tag(:i, ' Excellent', class: 'fa-solid fa-face-laugh-squint')
    else
      '評価なし'
    end
  end
end
