require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v1.0.2.tar.gz"
  sha1 "a3fcf99ecb5e1fb422a73f24de712fd0d1ed2876"
  head "https://#{PACKAGE}.git"

  depends_on "go" => :build

  def install
    (buildpath/"src/#{PACKAGE}").install Dir["./*.go"]

    ENV["GOPATH"] = buildpath

    system "go", "build", "-o", "rpenv", PACKAGE
    bin.install "rpenv"
  end

  test do
    `#{bin}/rpenv`
    assert_equal $?.to_i, 1
  end
end
