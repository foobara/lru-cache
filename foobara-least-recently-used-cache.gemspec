require_relative "version"

Gem::Specification.new do |spec|
  spec.name = "foobara-least-recently-used-cache"
  spec.version = Foobara::LeastRecentlyUsedCache::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "No description. Add one."
  spec.homepage = "https://github.com/foobara/least-recently-used-cache"
  spec.license = "Apache-2.0 OR MIT"
  spec.required_ruby_version = Foobara::LeastRecentlyUsedCache::MINIMUM_RUBY_VERSION

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE*.txt",
    "README.md",
    "CHANGELOG.md"
  ]

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
