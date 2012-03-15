require 'iron_mq'
require 'json'

trap("INT") { exit }

@token = '9uy03ZpIo96unFx7zR45_WY7QVU'
@project_id = '4f6129c6a859d05c200011d2'

puts "Consumer is consuming..."

client = IronMQ::Client.new(:token => @token, :project_id => @project_id)
counter = 1

def time
  start_time = Time.now
  yield
  Time.now - start_time
end

while true
  if client.queues.list.first.size == 0
    sleep(1.0/1000)
    next
  end

  begin
    duration = time do
      message = client.messages.get
      @params = JSON.parse(message.body)
      client.messages.delete(message.id)
    end

    puts "Result (took #{"%.02f" % duration}s) body: #{@params["num"]}**2 = #{@params["result"]}"
  rescue => e
    puts "THIS SHIT'S CRAY!"
    puts e.message
  end
end