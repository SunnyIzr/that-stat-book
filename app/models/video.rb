class Video < ActiveRecord::Base
  belongs_to :lesson
  has_attached_file :video,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :s3_protocol => 'https'
  has_attached_file :ogv_video,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :s3_protocol => 'https'
  do_not_validate_attachment_file_type :video

  def s3_credentials
    {:bucket => ENV['BUCKET'], :access_key_id => ENV['ACCESS_KEY_ID'], :secret_access_key => ENV['SECRET_ACCESS_KEY']}
  end
end
