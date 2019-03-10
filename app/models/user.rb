class User < Patron
  devise :invitable, :registerable, :confirmable

  def full_name
  	"#{first_name.humanize} #{last_name.humanize}"
  end
end
