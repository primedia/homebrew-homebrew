require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v3.0.5.tar.gz"
  sha256 "e636877534b1fdf1f59999a75028f410dafc23a658d7262805a929c0879fa4c0"
  head "https://#{PACKAGE}.git"

  depends_on "go" => :build

  def install
    (buildpath/"src/#{PACKAGE}").install Dir["./*"]

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
