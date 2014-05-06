module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "WORK FARM"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end
  def left_time(time1, time2)
    time = time1.to_i - time2.to_i
    time = time.abs

    if time > 60 
      s = time%60
      time = time/60
      if time > 60  
        m = time%60
        time = time/60
        if time > 24
          h = time%24
          time = time/24
          rep =  time.to_s + "days " + h.to_s + "hours"
        else
          rep =  time.to_s + "hours " + m.to_s + "min"
        end
      else
        rep = time.to_s + "min"
      end
    else
      rep = time.to_s + "second"
    end
  end
end
