# frozen_string_literal: true

require_relative "lib/renv/version"

Gem::Specification.new do |spec|
  spec.name = "renv"
  spec.version = Renv::VERSION
  spec.authors = ["tanahiro2010"]
  spec.email = ["herentongkegu087@gmail.com"]

  spec.summary = "A Ruby client sdk for Renv API"
  spec.description = "This gem provides a Ruby client sdk to interact with the Renv API for managing environment variables securely."
  spec.homepage = "https://renv-web.vercel.app/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Set the allowed push host. For public gems on RubyGems.org, use "https://rubygems.org".
  # If you publish to a private gem server, replace the value with that server's URL
  # (e.g. "https://gems.mycompany.com" or "https://rubygems.pkg.github.com/OWNER").
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/renv-dev/renv-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/renv-dev/renv-ruby/actions"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
