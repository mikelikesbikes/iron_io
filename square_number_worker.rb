require 'iron_mq'
require 'iron_worker'

class SquareNumberWorker < IronWorker::Base
  attr_accessor :number, :token, :project_id

  def run
    post_message({:num => number, :result => number * number})
  end

  private
  def post_message(message)
  	client.messages.post(message.to_json)
  end

  def client
  	@client ||= IronMQ::Client.new(:token => token, :project_id => project_id)
  end
end