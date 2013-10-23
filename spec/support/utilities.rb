def full_title(page_title)
  base_title = "Real Estate CRM"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end  
