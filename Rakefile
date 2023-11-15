date_string = Time.now.strftime("%Y-%m-%d")
params = "--attribute revdate='#{date_string}'"

image_files = Rake::FileList.new("src/images/*.png", "src/images/*.svg") do |fl|
  fl.exclude("~*")
  fl.exclude(/^scratch\//)
end

namespace :spec do
  directory 'build/images'

  desc 'copy images to build dir'
  task :images => 'build/images'

  image_files.each do |source|
    target = source.sub(/^src\/images/, 'build/images')
    file target => source do
      cp source, target, :verbose => true
      `pngquant -f #{target}`
    end
    desc "copies all data files"
    task :images => target
  end

  task :prereqs => [:images]
  
  desc 'build basic spec formats'
  task :html => :prereqs do
    begin
      puts "Converting to HTML..."
      `bundle exec asciidoctor -b html5 #{params} src/main.adoc -o build/PartiQL-Specification.html`
    end
  end

  task :pdf => :prereqs do
    begin
      theming = "-a pdf-themesdir=src/themes -a pdf-theme=basic -a pdf-fontsdir=fonts"
      stem = "-r asciidoctor-mathematical -a mathematical-format=svg"
      pdf_params = "-a compress"
      puts "Converting to PDF..."
      `bundle exec asciidoctor-pdf -v #{params} #{theming} #{stem} #{pdf_params} src/main.adoc -o build/PartiQL-Specification.pdf --trace`
    end
  end

  task :build => [:html, :pdf]

  task :watch do
    begin
      `bundle exec guard`
    end
  end

  require 'rake/clean'
  CLEAN.include('build/*')
  CLOBBER.include('build/*')
end

task :default => "spec:build"
