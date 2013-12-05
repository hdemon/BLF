# ruby-1.9.3

input_times = gets.to_i

result = input_times.times.map do
    input = gets.to_i
    input.match /((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])[.]){3}(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])/
end

r = result.map do |e|
    case
    when e == true then 'True'
    when e == false then 'False'
    end
end

r.each {|e| print e}
