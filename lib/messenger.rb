class Messenger
  
  def headers(output)
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def output(response)
    "<html><head></head><body>#{response}</body></html>"
  end
 
end