class RequestReader
  
  attr_accessor :diagnostics
  
  def initialize
  @diagnostics = {"Verb" => nil,
                  "Path" => nil,
                  "Protocol" => nil,
                  "Host" => nil,
                  "Port" => nil,
                  "Origin" => nil,
                  "Accept" => nil
  }
  end
  
end