require 'iron_worker'
require_relative 'square_number_worker'

trap("INT") { exit }

@token = '9uy03ZpIo96unFx7zR45_WY7QVU'
@project_id = '4f6129c6a859d05c200011d2'

IronWorker.configure do |config|
  config.token = @token
  config.project_id = @project_id
end

def time
  start_time = Time.now
  yield
  Time.now - start_time
end

# square the numbers 0 to 100 using Iron.io workers (intense)!
while true
  num = rand(10000)
  worker = SquareNumberWorker.new
  worker.number = num
  worker.token = @token
  worker.project_id = @project_id

  begin
    duration = time do
      worker.enqueue
    end
    puts "enqueued #{num}... (took #{"%.02f" % duration}s)."
  rescue => e
    puts "something terrible happened to #{num}'s worker!"
    puts e.message
  end
end