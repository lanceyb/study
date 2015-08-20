require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel
q = ch.queue("hello")

ch.prefetch(1)
puts "[*] Waiting for messages in #{q.name}. To exit press CTRL+C"

begin
  q.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"

    # cancel the consumer to exit
    # delivery_info.consumer.cancel
    sleep  1.0
    puts "[x] Done"

    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt =>
  conn.close
end
