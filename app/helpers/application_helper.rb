module ApplicationHelper
  AVATAR_1 = "https://68.media.tumblr.com/7d65a925636d6e3df94e2ebe30667c29/tumblr_nq1zg0MEn51qg6rkio1_500.jpg"
  AVATAR_2 = "https://68.media.tumblr.com/9f9b498bf798ef43dddeaa78cec7b027/tumblr_o51oavbMDx1ugpbmuo7_500.png"
  AVATAR_3 = "http://78.media.tumblr.com/75bad14fee104f69652084d545213291/tumblr_mldfty8fh41qcnibxo5_1280.png"
  AVATAR_4 = "https://68.media.tumblr.com/22d1c50c3e2ca1062a94b47a65bfeb6d/tumblr_o51oavbMDx1ugpbmuo10_500.png"
  
  def default_avatar(user)
    first_letter = user.name[0].downcase if user.name.present?
    first_letter ||= 'a'
    case
    when first_letter < 'h' then AVATAR_1
    when first_letter < 'n' then AVATAR_2
    when first_letter < 'u' then AVATAR_3
    else AVATAR_4
    end
  end

  def pluralize_comments(comments)
    comments_nb = comments.count
    if comments_nb == 0 || comments_nb == 1
      "#{comments_nb} comment"
    else
      "#{comments_nb} comments"
    end
  end

  def pluralize_tips(tips)
    tips_nb = tips.count
    if tips_nb == 0 || tips_nb == 1
      "#{tips_nb} tip"
    else
      "#{tips_nb} tips"
    end
  end
end
