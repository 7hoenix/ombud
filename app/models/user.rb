class User < ActiveRecord::Base

	devise :omniauthable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


				# This is for omniauth
				def self.from_omniauth(auth)
					where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
						user.email = auth.info.email
						user.password = Devise.friendly_token[0,20]
						user.name = auth.info.name   # assuming the user model has a name
						user.image = auth.info.image # assuming the user model has an image

					end
				end

				# This is for LinkedIn Omniauth
				def self.connect_to_linkedin(auth, signed_in_resource=nil)
					user = User.where(:provider => auth.provider, :uid => auth.uid).first
					if user
						return user
					else
						registered_user = User.where(:email => auth.info.email).first
						if registered_user
							return registered_user
						else
							user = User.create(name: auth.info.first_name,
							last_name: auth.info.last_name,
							provider: auth.provider,
							uid: auth.uid,
							email: auth.info.email,
							image: auth.info.image,
							description: auth.info.summary,
							headline: auth.info.headline,
							password: Devise.friendly_token[0,20]
							)
						end

					end
				end

end
