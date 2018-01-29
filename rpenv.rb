require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v3.0.0.tar.gz"
  sha256 "598dfd6ebd53f63a4d60a0253887532e9090683415bc3fa908b4f5ad24f2786a"
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
