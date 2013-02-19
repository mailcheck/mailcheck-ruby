# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mailcheck/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Scott Becker"]
  gem.email         = ["becker.scott@gmail.com"]
  gem.description   = %q{A ruby translation of the Kicksend mailcheck javascript library (https://github.com/Kicksend/mailcheck) which suggests a right domain when your users misspell it in an email address.}
  gem.summary       = %q{When your user types in "user@hotnail.con", Mailcheck will suggest "user@hotmail.com". Mailcheck will offer up suggestions for top level domains too, and suggest ".com" when a user types in "user@hotmail.cmo".}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mailcheck"
  gem.require_paths = ["lib"]
  gem.version       = Mailcheck::VERSION
  gem.add_development_dependency 'rspec', '~> 2.12'
end
