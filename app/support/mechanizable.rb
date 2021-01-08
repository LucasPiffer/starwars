module Mechanizable
  def agent
    @agent ||= Mechanize.new
  end

  def get(url)
    agent.get(url)
  end
end

