DIRS = FileList.new('./*') do |fl|
  fl.exclude { |f| not File.directory? f }
end

DEST = File.expand_path(File.join('~', '.emacs.d', 'private'))

task :install do
  DIRS.each do |d|
    sh %(ln -s #{File.expand_path(d)} #{File.join(DEST, File.basename(d))})
  end
end

task default: :install

