require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/primedia/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v1.0.0.tar.gz"
  sha1 "301e5fe3a14487fba17ecd1f94ed03a59db1a6e0"
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
