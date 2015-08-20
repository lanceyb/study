require "bunny"

conn = Bunny.new
conn.start
ch = conn.create_channel
q = ch.queue("hello")
#ch.default_exchange.publish("Hello World!", :routing_key => q.name)
#conn.close

msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"

sleep 1.0
conn.close