require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v1.0.1.tar.gz"
  sha1 "c54d38cbd9df801a46d205fa1f072e6d21c5003a"
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
