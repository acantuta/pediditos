class Promocion < ActiveRecord::Base

	has_attached_file :avatar, styles: {
		normal: '465x220#',
		medium: '233x110#'
	}

	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
