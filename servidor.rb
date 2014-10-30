require 'rubygems'
require 'em-websocket'

EM.run {
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8090) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

        Thread.new do
          while true do
            #Empieza en 100 para que no salgan unos colores blancos. aparentemente son varios rangos de blancos
            (0x000100...0xffffff).each do |color|
              #ws.send "##{color.to_s 16}"
              ws.send "document.body.style.backgroundColor = '##{color.to_s(16)}'; document.getElementById('span-color').innerHTML = '<strong>Color: </strong> ##{sprintf('%06x', color)}';"
              sleep 1
              puts 'Mensaje enviado. Color: ' + color.to_s(16)
            end
          end
        end
    }
    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
      ws.send "Pong: #{msg}"
    }
  end
}
