module FormHelpers
  def set_location(location, method=:manually)
    if method == :manually
      check "Manual Entry", allow_label_click: true, id: "use_location_override"
      fill_in "Location", with: location
    end
  end

  def set_dm_info(name, dci, method=:manually)
    if method == :manually
      check "Manual Entry", allow_label_click: true, id: "use_dm_override"
      fill_in "DM Name", with: name
      fill_in "DM DCI", with: dci
    end
  end
end