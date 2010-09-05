desc "Reset application data"
task :reset => ["mongo:reset", "images:reset"] do 
  puts "Application data is reset"
end
