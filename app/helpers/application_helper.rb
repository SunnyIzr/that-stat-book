module ApplicationHelper
  extend self
  def time(seconds)
    mins = seconds / 60
    secs = seconds % 60
    mins.to_s + ':' + secs.to_s.rjust(2,'0')
  end
end
