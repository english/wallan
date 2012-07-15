task :deploy do
  sh "middleman build"
  sh "git add ."
  sh "git commit -am 'build'"
  sh "rsync -ravz --delete build/* ubuntu@classiquekitchens.co.uk:apps/wallanscrap/"
end
