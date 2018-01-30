require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v3.0.2.tar.gz"
  sha256 "3234b5cf94330adc8dea7071c796d6790752d73deefb83cefa5287972aaf5549"
  head "https://#{PACKAGE}.git"

  depends_on "go" => :build

  def install
    (buildpath/"src/#{PACKAGE}").install Dir["./*.go"]

    ENV["GOPATH"] = buildpath

    system "go", "build", "-o", "rpenv", PACKAGE
    bin.install "rpenv"

    ohai "be sure to add a ~/.config/.rpenv file containing ci, qa, "
    ohai "and prod urls per the README of https://#{PACKAGE}."
  end

  test do
    `#{bin}/rpenv`
    assert_equal $?.to_i, 1
  end
end
