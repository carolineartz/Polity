module LegislationsHelper
  require 'will_paginate/array'
  def fresh_legislations
    Legislation.where.not("status = ?", "Voted")
  end

  def voted_legislations
      Legislation.where("status = ?", "Voted")
  end

  def paginate_legislations(legislations)
    displayed_legislations = legislations.pluck

    will_paginate(legislations.paginate(page: params[:page], per_page: 8))
  end

end
