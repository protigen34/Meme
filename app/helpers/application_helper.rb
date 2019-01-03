module ApplicationHelper
  def dow_to_abbrev(dow)
    map = {
      :sunday => 'Su',
      :monday => 'M',
      :tuesday => 'Tu',
      :wednesday => 'W',
      :thursday => 'Tr',
      :friday => 'F',
      :saturday => 'Sa'
    }
    map[dow]
  end
end
