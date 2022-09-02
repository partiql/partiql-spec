# See https://asciidoctor.org/docs/editing-asciidoc-with-live-preview/

Bundler.require :default

guard 'shell' do
  watch(/^.*\.adoc$/) {|m|
    `bundle exec rake spec:build`
  }
  watch(/^images\/.*$/) {|m|
    `bundle exec rake spec:build`
  }
  watch(/^hello-aws\/.*\.adoc$/) {|m|
    `bundle exec rake spec:build`
  }
  watch(/^.*\.yml$/) {|m|
    `bundle exec rake spec:build`
  }
  watch(/^themes\/.*\.yml$/) {|m|
    `bundle exec rake spec:build`
  }
end
