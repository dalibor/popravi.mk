module Admin::AttachmentsHelper

  def direct_attachment_url(attachment)
    "#{root_url}#{attachment.url(:original, false).gsub(/^\//, '')}"
  end
end
